//
//  File.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 06/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var overviewLabel: UILabel!
    
    private var item: Item!
    
    override func viewDidLoad() {
        titleLabel.text = item.displayTitle
        overviewLabel.text = item.overview
        
        guard let imageUrl = URLBuilder.shared.getImageUrlString(from: item), let imageName =  item.posterImageName else { return }
        APIDataHandler.getImage(witnName: imageName, urlString: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func closeButtonTouchedUp(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    class func create(with item: Item) -> DetailViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.item = item
        return vc
    }
}
