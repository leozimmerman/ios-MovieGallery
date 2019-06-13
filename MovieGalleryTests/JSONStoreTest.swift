//
//  JSONStoreTest.swift
//  MovieGalleryTests
//
//  Created by Leonardo Zimmerman on 10/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import XCTest

class JSONStoreTest: PagesTest {
    
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
