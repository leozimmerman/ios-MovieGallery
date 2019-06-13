//
//  MovieGalleryTests.swift
//  MovieGalleryTests
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import XCTest
@testable import MovieGallery

class PagesTest: XCTestCase {
    
    var moviesPage: MoviesPage!
    var tvShowsPage: TvShowsPage!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let decoder = JSONDecoder()
        
        let moviesFileUrl = bundle.url(forResource: "moviesPopular", withExtension: "json")
        let moviesFileData = try! Data(contentsOf: moviesFileUrl!)
        moviesPage = try? decoder.decode(MoviesPage.self, from: moviesFileData)
        
        let tvShowsFileUrl = bundle.url(forResource: "tvShowsPopular", withExtension: "json")
        let tvShowsFileData = try! Data(contentsOf: tvShowsFileUrl!)
        tvShowsPage = try? decoder.decode(TvShowsPage.self, from: tvShowsFileData)
    }

    override func tearDown() {
    }
    
    func testMoviesPage() {
        XCTAssert(moviesPage != nil)
        XCTAssertEqual(moviesPage?.total_pages, 991)
        XCTAssertEqual(moviesPage?.results.count, 20)
        XCTAssertEqual(moviesPage?.results[3].title, "Godzilla: King of the Monsters")
    }
    
    func testTvShowsPage() {
        XCTAssert(tvShowsPage != nil)
        XCTAssertEqual(tvShowsPage?.total_pages, 1000)
        XCTAssertEqual(tvShowsPage?.results.count, 20)
        XCTAssertEqual(tvShowsPage?.results[3].displayTitle, "Game of Thrones")
    }
}
