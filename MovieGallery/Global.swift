//
//  Types.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 05/06/2019.
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

enum CategoryType: String {
    case popular = "popular"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    case onTheAir = "on_the_air"
    
    var endpoint: String {
        return "/" + self.rawValue
    }
    
    func title() -> String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        case .onTheAir:
            return "On the Air"
        }
    }
    
    static var allTypes: [CategoryType] = [.popular, .topRated, .upcoming, .onTheAir]
}


