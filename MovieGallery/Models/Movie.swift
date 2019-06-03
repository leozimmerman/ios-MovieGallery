//
//  File.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

class Movie : Item {
    var title: String
    var original_title: String
    var adult: Bool
    var release_date: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case original_title
        case adult
        case release_date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        original_title = try container.decode(String.self, forKey: .original_title)
        adult = try container.decode(Bool.self, forKey: .adult)
        release_date = try container.decode(String.self, forKey: .release_date)
        try super.init(from: decoder)
    }
}
