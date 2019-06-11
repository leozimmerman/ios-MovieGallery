//
//  TvShowsPageTest.swift
//  MovieGalleryTests
//
//  Created by Leonardo Zimmerman on 10/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import XCTest

class TvShowsPageTest: XCTestCase {
    
    var fileData: Data!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "tvShowsPopular", withExtension: "json")
        fileData = try! Data(contentsOf: fileUrl!)
    }

    override func tearDown() {
        fileData = nil
    }

    func testExample() {
        let decoder = JSONDecoder()
        let tvShowsPage = try? decoder.decode(TvShowsPage.self, from: fileData!)
        
        XCTAssert(tvShowsPage != nil)
        XCTAssertEqual(tvShowsPage?.total_pages, 1000)
        XCTAssertEqual(tvShowsPage?.results.count, 20)
        XCTAssertEqual(tvShowsPage?.results[3].displayTitle, "Game of Thrones")
    }
}
