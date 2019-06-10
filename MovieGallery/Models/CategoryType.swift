//
//  Types.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 05/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

enum CategoryType: String {
    case popular = "popular"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    case onTheAir = "on_the_air"
    case airingToday = "airing_today"
    
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
        case .airingToday:
            return "Airing Today"
        }
    }
    
    static var allTypes: [CategoryType] = [.popular, .topRated, .upcoming, .onTheAir, .airingToday]
    static var moviesTypes: [CategoryType] = [.popular, .topRated, .upcoming]
    static var tvShowsTypes: [CategoryType] = [.popular, .topRated, .onTheAir, .airingToday]
}


