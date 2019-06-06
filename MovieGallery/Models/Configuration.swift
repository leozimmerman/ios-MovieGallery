//
//  Configuration.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 05/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

struct ImagesConfiguration: Codable {
    var base_url: String
    var secure_base_url: String
    var backdrop_sizes: [String]
    var logo_sizes: [String]
    var poster_sizes: [String]
    var profile_sizes: [String]
    var still_sizes: [String]
}

class Configuration : Codable {
    var images: ImagesConfiguration
    var change_keys: [String]
}




