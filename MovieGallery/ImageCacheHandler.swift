//
//  ImageCacheHandler.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 07/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class ImageCacheHandler {
    static let shared = ImageCacheHandler()
    private let cache = NSCache<AnyObject, AnyObject>()
    
    func getImage(withKey key: String) -> UIImage? {
        return cache.object(forKey: key as AnyObject) as? UIImage
    }
    
    func setImage(_ image: UIImage, withKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
    }
}
