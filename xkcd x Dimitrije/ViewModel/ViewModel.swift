//
//  ViewModel.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {
    @Published var currentComic: Comic?
    @Published var requestedComic: Comic?
    @Published var randomComic: Comic?
    @Published var favouriteComics: [Comic] = [] {
        didSet {
            saveFavourites()
        }
    }
    
    
    static let shared = ViewModel()
    private let comicService =  ComicService.shared
    
    init() {
        self.getCurrent()
        self.loadFavourites()
    }
    
    // Comic Service Functions
    
    func getCurrent() {
        Task {
            do {
                let comic = try await comicService.getCurrentComic()
                DispatchQueue.main.async {
                    self.currentComic = comic
                }
            }
            catch {
                Logger.log("Could not fetch current comic.", reason: .error)
            }
        }
    }
    
    func getSpecific(number: Int) {
        Task {
            do {
                let comic = try await comicService.getSpecificComic(number: number)
                DispatchQueue.main.async {
                    self.requestedComic = comic
                }
            }
            catch {
                Logger.log("Could not fetch comic with num \(number).", reason: .error)
            }
        }
    }
    
    func getRandom() {
        Task {
            do {
                let comic = try await comicService.getRandomComic()
                DispatchQueue.main.async {
                    self.currentComic = comic
                }
            }
            catch {
                Logger.log("Could not fetch random comic.", reason: .error)
            }
        }
    }
    
    // UserDefaults & Favourite Functions
    
    func favCurrent() {
        guard self.currentComic != nil else {
            Logger.log("Can't add nil to favs", reason: .error)
            return
        }
        guard self.currentComic?.liked == false else {self.favouriteComics.removeAll(where: {$0.num == self.currentComic?.num})
            Logger.log("Removed \(self.currentComic?.title ?? "something") from favs")
            return
        }
        self.favouriteComics.append(self.currentComic!)
        Logger.log("Added \(self.currentComic?.title ?? "something") to favs")
    }
    
    func saveFavourites() {
        let data = try? JSONEncoder().encode(favouriteComics)
        UserDefaults.standard.set(data, forKey: "favourites")
        Logger.log("Saved favs to UserDefaults.", reason: .info)
    }
    
    func loadFavourites() {
        if let data = UserDefaults.standard.data(forKey: "favourites"),
           let comics = try? JSONDecoder().decode([Comic].self, from: data) {
            self.favouriteComics = comics
        } else {
            Logger.log("No Favourites Found in UserDefaults", reason: .warning)
        }

    }
    
    // Other Functions
    
    func share(_ items: [Any]) {
        let av = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    
}
