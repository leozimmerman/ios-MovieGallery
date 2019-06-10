//
//  StorageManager.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 07/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class StorageManager {
    class var allStoredItems: [Item]? {
        return ItemType.allTypes.flatMap { (itemType) -> [Item] in
            return CategoryType.allTypes.flatMap({ (categoryType) -> [Item] in
                return StorageManager.loadMoviesPage(itemType: itemType, categoryType: categoryType)?.items ?? [Item]()
            })
        }
    }
    
    class func savePage(_ page: Page, categoryType: CategoryType) {
        if let moviesPage = page as? MoviesPage {
            let filename = StorageManager.getPageFilename(with: .movie, categoryType: categoryType)
            let store = JSONStore<MoviesPage>(storageType: StorageType.cache, filename: filename)
            store.save(moviesPage)
        } else if let tvShowsPage = page as? TvShowsPage {
            let filename = StorageManager.getPageFilename(with: .tvShow, categoryType: categoryType)
            let store = JSONStore<TvShowsPage>(storageType: StorageType.cache, filename: filename)
            store.save(tvShowsPage)
        }
    }
    
    class func loadMoviesPage(itemType: ItemType, categoryType: CategoryType) -> Page? {
        let filename = getPageFilename(with: itemType, categoryType: categoryType)
        switch itemType {
        case .movie:
            let store = JSONStore<MoviesPage>(storageType: StorageType.cache, filename: filename)
            return store.storedValue
        case .tvShow:
            let store = JSONStore<TvShowsPage>(storageType: StorageType.cache, filename: filename)
            return store.storedValue
        }
    }
    
    class func saveConfiguration(_ configuration: Configuration) {
        let filename = "configuration"
        let store = JSONStore<Configuration>(storageType: StorageType.cache, filename: filename)
        store.save(configuration)
    }
    
    class func loadConfiguration() -> Configuration? {
        let store = JSONStore<Configuration>(storageType: StorageType.cache, filename: "configuration")
        return store.storedValue
    }
    
    class func saveImage(_ image: UIImage, name: String) {
        let pathURL: URL =  StorageType.permanent.baseFolder.appendingPathComponent(name)
        do {
            try image.jpegData(compressionQuality: 1)?.write(to: pathURL)
        } catch {
            print("StorageManager: error saving image")
        }
    }
    
    class func loadImage(withName name: String) -> UIImage? {
        let fileUrlPath = StorageType.permanent.baseFolder.appendingPathComponent(name).path
        return UIImage(contentsOfFile: fileUrlPath)
    }

    private class func getPageFilename(with itemType: ItemType, categoryType: CategoryType) -> String {
        return itemType.rawValue + "-" + categoryType.rawValue
    }
    
}
