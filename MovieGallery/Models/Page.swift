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
    
    var items : [Item] { return [Item]() }
    
    private enum CodingKeys: String, CodingKey {
        case page
        case total_results
        case total_pages
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(total_results, forKey: .total_results)
        try container.encode(total_pages, forKey: .total_pages)
    }
}






