//
//  ItemsSearchTest.swift
//  MovieGalleryTests
//
//  Created by Leonardo Zimmerman on 11/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import XCTest
@testable import MovieGallery

class ItemsSearchTest: XCTestCase {
    
    var items: [Item]!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let decoder = JSONDecoder()
        
        let moviesPagefileUrl = bundle.url(forResource: "moviesPopular", withExtension: "json")
        let moviesPagefileData = try! Data(contentsOf: moviesPagefileUrl!)
        let moviesPage = try? decoder.decode(MoviesPage.self, from: moviesPagefileData)
        items = moviesPage?.results
    }

    override func tearDown() {
        items = nil
    }

    func testPerformanceExample() {
        self.measure {
            let filteredItems_ar = ItemsFilter.filterItems(items, withText: "ar")
            let filteredItems_of = ItemsFilter.filterItems(items, withText: "of")
            let filteredItems_ls = ItemsFilter.filterItems(items, withText: "ls")
            
            XCTAssertEqual(filteredItems_ar.count, 7)
            XCTAssertEqual(filteredItems_of.count, 3)
            XCTAssertEqual(filteredItems_ls.count, 0)
        }
    }
}
