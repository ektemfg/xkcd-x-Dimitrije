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
    @Published var favouriteComics: [Comic] = []
    
    
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
                    self.currentComic = comic
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
    
    func favOrRemove(comic: Comic?) {
        let targetComic = comic ?? self.currentComic
        guard targetComic != nil else {
            Logger.log("Can't add/remove nil to/from favs", reason: .error)
            return
        }
        
        if let index = favouriteComics.firstIndex(where: { $0.num == targetComic?.num }) {
            favouriteComics.remove(at: index)
            Logger.log("Removed \(targetComic?.title ?? "something") from favs")
            saveFavourites()
        } else {
            favouriteComics.append(targetComic!)
            Logger.log("Added \(targetComic?.title ?? "something") to favs")
            saveFavourites()
        }
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
    
    func todayDateText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let timestamp = dateFormatter.string(from: Date())
        return timestamp
    }
    
    
}
