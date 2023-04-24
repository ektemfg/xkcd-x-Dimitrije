//
//  Comic.swift
//  xkcd x Dimitrije
//
//  Created by Dimitrije Pesic on 24/04/2023.
//

import Foundation

struct Comic: Codable {
    let month: String
    let num: Int
    let link, year, news, safeTitle: String
    let transcript, alt: String
    let img: String
    let title, day: String
    
    var url : URL? {
        return URL(string: self.img)
    }
    
    var liked: Bool {
        return ViewModel.shared.favouriteComics.contains(where: { $0.num == self.num })
    }
    
    
    enum CodingKeys: String, CodingKey {
        case month, num, link, year, news
        case safeTitle = "safe_title"
        case transcript, alt, img, title, day
    }
    
}
