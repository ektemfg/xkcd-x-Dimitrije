//
//  APIEndpoints.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//  For MVP - specific or current comic API url calculation
//

import Foundation

enum APIEndpoints {
    private static let baseUrl = "https://xkcd.com/"
    private static let jsonPath = "/info.0.json"
    
    case currentComic
    case comic(Int)
    
    var url: URL? {
        switch self {
        case .currentComic:
            return URL(string: APIEndpoints.baseUrl + APIEndpoints.jsonPath)
        case .comic(let number):
            return URL(string: APIEndpoints.baseUrl + "\(number)" + APIEndpoints.jsonPath)
        }
    }
    
}
