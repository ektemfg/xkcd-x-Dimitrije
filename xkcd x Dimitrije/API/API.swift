//
//  API.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//  This will contain API functionality to be called from new ComicService.
//

import Foundation

class API {
    
    let endpoints = APIEndpoints.self
    let decoder = JSONDecoder()
    static var shared: API = {
        API()
    }()
    
    func comicFetcher(_ type: String, number: Int?) async throws -> Comic {
        var comicUrl: URL? {
            switch type {
            case "current":
                return endpoints.currentComic.url
            case "specific":
                guard number != nil else {
                    Logger.log("User wanted specific comic, but comic num is nil", reason: .error)
                    return nil}
                return endpoints.comic(number!).url
            case "random":
                return endpoints.comic(Int.random(in: 1...2764)).url
            default:
                Logger.log("Unknown action, can't create comic URL.", reason: .error)
                return nil
            }
        }
        guard comicUrl != nil else {
            Logger.log("Could not create comic url.", reason: .error)
            throw APIError.invalidUrl
        }
        let urlRequest = URLRequest(url: comicUrl!)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            Logger.log("Network Error. Request could not complete.", reason: .error)
            throw APIError.networkError
            
        }
        let fetchedComic = try decoder.decode(Comic.self, from: data)
        return fetchedComic
        
    }
}
