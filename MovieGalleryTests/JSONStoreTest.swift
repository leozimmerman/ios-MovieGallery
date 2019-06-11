//
//  JSONStoreTest.swift
//  MovieGalleryTests
//
//  Created by Leonardo Zimmerman on 10/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import XCTest

class JSONStoreTest: XCTestCase {
    
    var moviesPage: MoviesPage!
    var tvShowsPage: TvShowsPage!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let decoder = JSONDecoder()
        
        let moviesPagefileUrl = bundle.url(forResource: "moviesPopular", withExtension: "json")
        let moviesPagefileData = try! Data(contentsOf: moviesPagefileUrl!)
        moviesPage = try? decoder.decode(MoviesPage.self, from: moviesPagefileData)
        
        let tvShowsPageFileUrl = bundle.url(forResource: "tvShowsPopular", withExtension: "json")
        let tvShowsPageFileData = try! Data(contentsOf: tvShowsPageFileUrl!)
        tvShowsPage = try? decoder.decode(TvShowsPage.self, from: tvShowsPageFileData)
    }

    override func tearDown() {
        moviesPage = nil
        tvShowsPage = nil
    }

    func testStorage() {
        let moviesStore = JSONStore<MoviesPage>(storageType: StorageType.cache, filename: "moviesPage")
        moviesStore.save(moviesPage)
        
        XCTAssert(moviesStore.storedValue != nil)
        XCTAssertEqual(moviesStore.storedValue?.total_pages, 991)
        XCTAssertEqual(moviesStore.storedValue?.results.count, 20)
        
        let tvShowsStore = JSONStore<TvShowsPage>(storageType: StorageType.cache, filename: "tvShowsPage")
        tvShowsStore.save(tvShowsPage)
        
        XCTAssert(tvShowsStore.storedValue != nil)
        XCTAssertEqual(tvShowsStore.storedValue?.total_pages, 1000)
        XCTAssertEqual(tvShowsStore.storedValue?.results.count, 20)
    }
}
