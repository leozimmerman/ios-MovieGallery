//
//  UIImageView+Helpers.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 06/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

extension UIImageView {
    //TODO: Add completion
    func fetch(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func fetch(from link: String) {
        guard let url = URL(string: link) else { return }
        fetch(from: url)
    }
}
