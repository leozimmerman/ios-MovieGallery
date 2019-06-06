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
        titleLabel.text = {
            if let movieItem = item as? Movie {
                return movieItem.title
            } else if let tvShowItem = item as? TvShow {
                return tvShowItem.original_name
            }
            return ""
        }()
        overviewLabel.text = item.overview
        
        if let configuration = APIManager.shared.systemConfiguration {
            let imageUrlPath = item.posterFullPath(with: configuration)
            imageView.fetch(from: imageUrlPath)
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
