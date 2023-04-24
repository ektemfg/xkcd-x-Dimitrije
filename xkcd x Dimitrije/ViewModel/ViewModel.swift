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
    
    static let shared = ViewModel()
    private let comicService =  ComicService.shared
    
    init() {
        self.getCurrent()
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
    
    // Other Functions
    
    func share(_ items: [Any]) {
        let av = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
}
