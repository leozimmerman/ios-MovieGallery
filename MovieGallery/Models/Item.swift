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
    var backdrop_path: String?
    var original_language: String
    var id: Int
    var vote_average: Float
    var overview: String
    var poster_path: String?
    
    var displayTitle: String { return String() }
    
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genre_ids, forKey: .genre_ids)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(vote_count, forKey: .vote_count)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(original_language, forKey: .original_language)
        try container.encode(id, forKey: .id)
        try container.encode(vote_average, forKey: .vote_average)
        try container.encode(overview, forKey: .overview)
        try container.encode(poster_path, forKey: .poster_path)
    }
    
    var posterImageName: String? {
        return poster_path?.replacingOccurrences(of: "/", with: "")
    }
}
