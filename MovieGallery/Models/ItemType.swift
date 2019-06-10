//
//  ItemType.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 10/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

enum ItemType: String {
    case movie = "movie"
    case tvShow = "tv"
    
    var endpoint: String {
        return "/" + self.rawValue
    }
    
    func title() -> String {
        switch self {
        case .movie:
            return "Movies"
        case .tvShow:
            return "Tv Shows"
        }
    }
    
    static var allTypes: [ItemType] = [.movie, .tvShow]
}
