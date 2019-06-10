//
//  URLBuilder.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 08/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

class URLBuilder {
    static let shared = URLBuilder()
    
    private let mainUrl: String = "https://api.themoviedb.org/3"
    private let keyNameApiKey: String = "api_key"
    
    private lazy var apiKey = Bundle.main.object(forInfoDictionaryKey: "API Key") as? String
    
    private(set) var configuration: Configuration?
    
    func fetchConfiguration() {
        guard let url = createConfigurationUrl() else { return }
        APIDataHandler.getConfiguration(url: url) { (configuration) in
            guard let config = configuration else {
                print("URLBuilder: Error retrieving API configuration")
                return
            }
            self.configuration = config
        }
    }
    
    func getImageUrlString(from item: Item) -> String? {
        guard let configuration = self.configuration else {
            fetchConfiguration()
            return nil
        }
        let baseUrl = configuration.images.base_url
        let size = configuration.images.poster_sizes[3]
        guard let path = item.poster_path else { return nil }
        return baseUrl + size + path
    }
    
    func pageUrl(with itemType: ItemType, categoryType: CategoryType) -> URL? {
        let urlString = createPageUrlString(with: itemType, categoryType: categoryType)
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: keyNameApiKey, value: apiKey),
        ]
        return components.url
    }
    
    private func createPageUrlString(with itemType: ItemType, categoryType: CategoryType) -> String {
        return mainUrl + itemType.endpoint + categoryType.endpoint
    }
    
    func createConfigurationUrl() -> URL? {
        let urlString = mainUrl + "/configuration"
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: keyNameApiKey, value: apiKey),
        ]
        return components.url
    }
    
    
}
