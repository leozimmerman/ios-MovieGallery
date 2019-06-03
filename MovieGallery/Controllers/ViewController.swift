//
//  ViewController.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchData(){
        APIManager.shared.fetchPage(with: .tvShow, categoryType: .onTheAir, pageNumber: 2) { (page) in
            if let results = page?.results {
                self.items = results
            }
        }
    }
}

