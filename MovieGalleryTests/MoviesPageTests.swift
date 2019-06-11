//
//  MovieGalleryTests.swift
//  MovieGalleryTests
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import XCTest
@testable import MovieGallery

class MoviesPageTests: XCTestCase {
    
    var fileData: Data!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "moviesPopular", withExtension: "json")
        fileData = try! Data(contentsOf: fileUrl!)
    }

    override func tearDown() {
        fileData = nil
    }
    
    func testDecoding() {
        let decoder = JSONDecoder()
        let moviesPage = try? decoder.decode(MoviesPage.self, from: fileData!)
        
        XCTAssert(moviesPage != nil)
        XCTAssertEqual(moviesPage?.total_pages, 991)
        XCTAssertEqual(moviesPage?.results.count, 20)
        XCTAssertEqual(moviesPage?.results[3].title, "Godzilla: King of the Monsters")
    }
}
