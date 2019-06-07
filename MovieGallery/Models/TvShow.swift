//
//  TvShow.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

class TvShow : Item {
    var original_name: String
    var origin_country: [String]
    var first_air_date: String
    
    override var name: String {
        return original_name
    }
    
    private enum CodingKeys: String, CodingKey {
        case original_name
        case origin_country
        case first_air_date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        original_name = try container.decode(String.self, forKey: .original_name)
        origin_country = try container.decode([String].self, forKey: .origin_country)
        first_air_date = try container.decode(String.self, forKey: .first_air_date)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(original_name, forKey: .original_name)
        try container.encode(origin_country, forKey: .origin_country)
        try container.encode(first_air_date, forKey: .first_air_date)
        try super.encode(to: encoder)
    }
}
