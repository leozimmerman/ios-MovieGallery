//
//  APIManager.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit


class APIDataHandler {
    // MARK: Public
    class func getStoredPage(with itemType: ItemType, categoryType: CategoryType) -> Page? {
        return StorageManager.loadMoviesPage(with: itemType, categoryType: categoryType)
    }
        
    class func fetchPage(with itemType: ItemType, categoryType: CategoryType, completion: @escaping (Page?)->()) {
        guard let url = URLBuilder.shared.pageUrl(with: itemType, categoryType: categoryType) else {
            completion(nil)
            return
        }
        switch itemType {
        case .movie:
            fetchMoviesPage(with: url) { (moviesPage) in
                if let mp = moviesPage {
                    StorageManager.savePage(mp, categoryType: categoryType)
                }
                completion(moviesPage)
            }
        case .tvShow:
            fetchTvShowsPage(with: url) { (tvShowsPage) in
                if let tvp = tvShowsPage {
                    StorageManager.savePage(tvp, categoryType: categoryType)
                }
                completion(tvShowsPage)
            }
        }
    }
    
    class func getConfiguration(url: URL, completion: @escaping (Configuration?)->()) {
        if let configurationFromStorage = StorageManager.loadConfiguration() {
            completion(configurationFromStorage)
        } else {
            DataTaskFactory.decodableDataTask(with: url) { (configuration: Configuration?) in
                if let configuration = configuration {
                    StorageManager.saveConfiguration(configuration)
                }
                completion(configuration)
            }.resume()
        }
    }
    
    class func getImage(witnName name: String, urlString: String, completion: @escaping (UIImage?)->()) {
        if let imageFromCache = ImageCacheHandler.shared.getImage(withKey: urlString) {
            completion(imageFromCache)
        } else if let imageFromStorage = StorageManager.loadImage(withName: name){
            completion(imageFromStorage)
        } else {
            guard let url = URL(string: urlString) else { return }
            DataTaskFactory.imageDataTask(with: url) { (image) in
                if let image = image {
                    ImageCacheHandler.shared.setImage(image, withKey: urlString)
                    StorageManager.saveImage(image, name: name)
                }
                completion(image)
            }.resume()
        }
    }
    
    // MARK: Private
    private class func fetchMoviesPage(with url: URL, completion: @escaping (MoviesPage?)->()) {
        DataTaskFactory.decodableDataTask(with: url, completion: completion).resume()
    }
    
    private class func fetchTvShowsPage(with url: URL, completion: @escaping (TvShowsPage?)->()) {
        DataTaskFactory.decodableDataTask(with: url, completion: completion).resume()
    }
}
