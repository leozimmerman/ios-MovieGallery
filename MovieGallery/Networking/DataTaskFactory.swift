//
//  DataTaskFactory.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 08/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class DataTaskFactory {
    class func imageDataTask(with url: URL, completion: @escaping (UIImage?)->()) -> URLSessionDataTask {
        return dataTask(with: url, completion: { (responseData) in
            guard let data = responseData else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        })
    }
    
    class func decodableDataTask<T: Codable>(with url: URL, completion: @escaping (T?)->()) -> URLSessionDataTask {
        return dataTask(with: url) { (responseData) in
            guard let data = responseData else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(decodedObject)
            } catch let e  {
                print("Error decoding JSON: \(e)")
                completion(nil)
            }
        }
    }
    
    class func dataTask(with url: URL, completion: @escaping (Data?)->()) -> URLSessionDataTask {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        return session.dataTask(with: urlRequest) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, let responseData = data, error == nil else {
                completion(nil)
                return
            }
            completion(responseData)
        }
    }
}
