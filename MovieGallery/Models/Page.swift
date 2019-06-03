//
//  Category.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

struct Page : Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results : [Item]
}
