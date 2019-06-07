//
//  StorageManager.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 07/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    
    //TODO: Check using Types
    func saveMoviesPage(_ moviesPage: MoviesPage, itemType: ItemType, categoryType: CategoryType) {
        let filename = getFilename(with: itemType, categoryType: categoryType)
        let store = LocalJSONStore<MoviesPage>(storageType: StorageType.cache, filename: filename)
        store.save(moviesPage)
    }
    
    func saveTvShowsPage(_ moviesPage: TvShowsPage, itemType: ItemType, categoryType: CategoryType) {
        let filename = getFilename(with: itemType, categoryType: categoryType)
        let store = LocalJSONStore<TvShowsPage>(storageType: StorageType.cache, filename: filename)
        store.save(moviesPage)
    }
    
    
    func loadMoviesPage(itemType: ItemType, categoryType: CategoryType) -> MoviesPage? {
        let filename = getFilename(with: itemType, categoryType: categoryType)
        let store = LocalJSONStore<MoviesPage>(storageType: StorageType.cache, filename: filename)
        return store.storedValue
    }
    
    func loadTvShowsPage(itemType: ItemType, categoryType: CategoryType) -> TvShowsPage? {
        let filename = getFilename(with: itemType, categoryType: categoryType)
        let store = LocalJSONStore<TvShowsPage>(storageType: StorageType.cache, filename: filename)
        return store.storedValue
    }
    
    func saveImage(_ image: UIImage, name: String) {
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let url = URL(fileURLWithPath: path).appendingPathComponent(name)
        do {
            try image.jpegData(compressionQuality: 1)?.write(to: url)
        } catch {
            print("StorageManager: error saving image")
        }
    }
    
    func loadImage(withName name: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false),
            let img =
            UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(name).path) {
            return img
        }
        return nil
    }
    
    private func getFilename(with itemType: ItemType, categoryType: CategoryType) -> String {
        return itemType.rawValue + "-" + categoryType.rawValue
    }
    
}
