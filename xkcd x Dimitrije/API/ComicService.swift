//
//  ComicService.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import Foundation

class ComicService {
    let api: API
    
    init(api: API = API.shared) {
        self.api = api
    }
    
    static let shared = ComicService(api: API.shared)
    
    func getCurrentComic() async throws -> Comic {
        try await api.comicFetcher("current", number: nil)
    }
    
    func getSpecificComic(number: Int) async throws -> Comic {
        try await api.comicFetcher("specific", number: number)
    }
    
    func getRandomComic() async throws -> Comic {
        try await api.comicFetcher("random", number: nil)
    }
}
