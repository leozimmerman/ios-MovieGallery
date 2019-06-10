//
//  MoviesPage.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 07/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

final class MoviesPage : Page {
    var results : [Movie]
    
    override var items: [Item] { return results }
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([Movie].self, forKey: .results)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try super.encode(to: encoder)
    }
}
