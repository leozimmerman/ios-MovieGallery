//
//  ItemCollectionViewCell.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 05/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

final class ItemCollectionViewCell : UICollectionViewCell {
    
    static let reuseIdentifier = "ItemCollectionViewCell"
    
    @IBOutlet var imageView: UIImageView!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func setup(with item: Item) {
        guard let imageUrl = URLBuilder.shared.getImageUrlString(from: item), let imageName = item.posterImageName else { return }
        DataHandler.shared.getImage(witnName: imageName, urlString: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}


