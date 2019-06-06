//
//  Category.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

class Page : Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    
    private enum CodingKeys: String, CodingKey {
        case page
        case total_results
        case total_pages
    }
}

class MoviesPage : Page {
    var results : [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([Movie].self, forKey: .results)
        try super.init(from: decoder)
    }
}

class TvShowsPage : Page {
    var results : [TvShow]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([TvShow].self, forKey: .results)
        try super.init(from: decoder)
    }
}


