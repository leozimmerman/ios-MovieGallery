//
//  UIImageView+Helpers.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 06/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit



extension UIImage {
    func save(_ name: String) {
        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let url = URL(fileURLWithPath: path).appendingPathComponent(name)
        do {
            //try self.pngData()?.write(to: url)
            try self.jpegData(compressionQuality: 1)?.write(to: url)
            print("saved image at \(url)")
        } catch {
            print("error saving image")
        }
    }
    
    
}

extension UIImageView {
    func loadImage(name: String, urlString: String){
        
        if let imageFromCache = ImageCacheHandler.shared.getImage(withKey: urlString) {
            self.image = imageFromCache
            return
        }
        
        if let imageFromStorage = StorageManager.shared.loadImage(withName: name) {
            self.image = imageFromStorage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if let responseData = data {
                DispatchQueue.main.async {
                    if let image = UIImage(data: responseData) {
                        self.image = image
                        ImageCacheHandler.shared.setImage(image, withKey: urlString)
                        StorageManager.shared.saveImage(image, name: name)
                    }
                }
            }
            }.resume()
    }
}
