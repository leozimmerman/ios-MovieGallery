//
//  APIManager.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import Foundation

enum ItemType: String {
    case movie = "/movie"
    case tvShow = "/tv"
}

enum CategoryType: String {
    case popular = "/popular"
    case topRated = "/top_rated"
    case upcoming = "/upcoming"
    case onTheAir = "/on_the_air"
}

class APIManager {
    static let shared = APIManager()
    
    private let mainUrl: String = "https://api.themoviedb.org/3"
    private let keyNameApiKey: String = "api_key"
    private let keyNamePage: String = "page"
    
    private lazy var apiKey = Bundle.main.object(forInfoDictionaryKey: "API Key") as? String
    
    func fetchPage(with itemType: ItemType, categoryType: CategoryType, pageNumber: Int, completion: @escaping (Page?)->()) {
        
        guard let url = createUrl(with: itemType, categoryType: categoryType, pageNumber: pageNumber) else {
            print("Error: cannot create URL")
            completion(nil)
            return
        }
        let task = createDataTask(with: url, completion: completion)
        task.resume()
    }
    
    private func createUrlString(with itemType: ItemType, categoryType: CategoryType) -> String {
        return mainUrl + itemType.rawValue + categoryType.rawValue
    }
    
    private func createUrl(with itemType: ItemType, categoryType: CategoryType, pageNumber: Int) -> URL? {
        let urlString = createUrlString(with: itemType, categoryType: categoryType)
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        components.queryItems = [
            URLQueryItem(name: keyNameApiKey, value: apiKey),
            URLQueryItem(name: keyNamePage, value: String(pageNumber))
        ]
        return components.url
    }
    
    private func createDataTask(with url: URL, completion: @escaping (Page?)->()) -> URLSessionDataTask {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        return session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let err = error {
                print (err)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: It's not a HTTP URL response")
                return
            }
            print("Response status code: \(httpResponse.statusCode)")
            print("Response status localizedString: \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieCategory = try decoder.decode(Page.self, from: responseData)
                completion(movieCategory)
            } catch  {
                print("error decoding JSON")
                completion(nil)
                return
            }
        }
    }

}
