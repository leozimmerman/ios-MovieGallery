//
//  Item.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

class Item: Codable {
    var genre_ids: [Int]
    var popularity: Double
    var vote_count: Int
    var backdrop_path: String
    var original_language: String
    var id: Int
    var vote_average: Float
    var overview: String
    var poster_path: String
    
    private enum CodingKeys: String, CodingKey {
        case genre_ids
        case popularity
        case vote_count
        case backdrop_path
        case original_language
        case id
        case vote_average
        case overview
        case poster_path
    }
}
