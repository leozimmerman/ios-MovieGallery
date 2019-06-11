//
//  ItemsFilter.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 11/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

final class ItemsFilter {
    class func filterItems(_ items: [Item], withText text: String) -> [Item] {
        return items.filter({ (item) -> Bool in
            item.displayTitle.lowercased().contains(text.lowercased())
        })
    }
}
