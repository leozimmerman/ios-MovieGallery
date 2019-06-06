//
//  ItemCollectionViewCell.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 05/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class ItemCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    func setup(with item: Item) {
        if let configuration = APIManager.shared.systemConfiguration {
            let imageUrlPath = item.posterFullPath(with: configuration)
            imageView.fetch(from: imageUrlPath)
        }
    }
    
}


