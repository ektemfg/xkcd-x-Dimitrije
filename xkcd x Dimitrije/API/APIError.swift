//
//  APIError.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//  We will have a enum here for possible API errors that can occur.
//
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case invalidData
    case invalidJSON
    case networkError
}
