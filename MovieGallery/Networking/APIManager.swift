//
//  APIManager.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    private let mainUrl: String = "https://api.themoviedb.org/3"
    private let keyNameApiKey: String = "api_key"
    
    private lazy var apiKey = Bundle.main.object(forInfoDictionaryKey: "API Key") as? String
    
    private(set) var systemConfiguration: Configuration?
    
    private func fetchConfiguration(completion: @escaping ()->()) {
        guard let url = createConfigurationUrl() else {
            print("Error: cannot create URL")
            return
        }
        let task = createConfigurationDataTask(with: url) { (configuration) in
            if let config = configuration {
                self.systemConfiguration = config
                completion()
            }
        
        }
        task.resume()
    }
    
    private func createConfigurationUrl() -> URL? {
        let urlString = mainUrl + "/configuration"
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: keyNameApiKey, value: apiKey),
        ]
        return components.url
    }
    
    func fetchPage(with itemType: ItemType, categoryType: CategoryType, completion: @escaping (Page?)->()) {
        
        if systemConfiguration == nil {
            fetchConfiguration {
                self.fetchPage(with: itemType, categoryType: categoryType, completion: completion)
            }
            return
        }
        
        guard let url = createPageUrl(with: itemType, categoryType: categoryType) else {
            print("Error: cannot create URL")
            completion(nil)
            return
        }
        
        let task: URLSessionDataTask = {
            switch itemType {
            case .movie:
                return createMoviesPageDataTask(with: url, completion: completion)
            case .tvShow:
                return createTvShowsPageDataTask(with: url, completion: completion)
            }
        }()
        
        task.resume()
    }
    
    private func createPageUrlString(with itemType: ItemType, categoryType: CategoryType) -> String {
        return mainUrl + itemType.endpoint + categoryType.endpoint
    }
    
    private func createPageUrl(with itemType: ItemType, categoryType: CategoryType) -> URL? {
        let urlString = createPageUrlString(with: itemType, categoryType: categoryType)
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: keyNameApiKey, value: apiKey),
        ]
        return components.url
    }
    
    //TODO: Fix type
    private func createMoviesPageDataTask(with url: URL, completion: @escaping (Page?)->()) -> URLSessionDataTask {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        return session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil else {
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                let page = try decoder.decode(MoviesPage.self, from: data)
                completion(page)
            } catch  {
                print("error decoding JSON")
                completion(nil)
                return
            }
        }
    }
    
    private func createTvShowsPageDataTask(with url: URL, completion: @escaping (Page?)->()) -> URLSessionDataTask {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        return session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil else {
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                let page = try decoder.decode(TvShowsPage.self, from: data)
                completion(page)
            } catch  {
                print("error decoding JSON")
                completion(nil)
                return
            }
        }
    }
    
    private func createConfigurationDataTask(with url: URL, completion: @escaping (Configuration?)->()) -> URLSessionDataTask {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        return session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil else {
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                let configuration = try decoder.decode(Configuration.self, from: data)
                completion(configuration)
            } catch  {
                print("error decoding JSON")
                completion(nil)
                return
            }
        }
    }

}
