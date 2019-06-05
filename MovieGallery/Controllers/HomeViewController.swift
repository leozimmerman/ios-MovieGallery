//
//  ViewController.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 03/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet private var sectionsSelectorView: SectionsSelectorView! {
        didSet {
            sectionsSelectorView.delegate = self
        }
    }
    @IBOutlet private var sectionsSelectorHeightConstraint: NSLayoutConstraint!
    
    private var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectorViewCollapsed(sectionsSelectorView.isCollapsed, animated: false)
        fetchData()
        
    }
    
    func fetchData(){
        APIManager.shared.fetchPage(with: .movie, categoryType: .popular, pageNumber: 2) { (page) in
            if let results = page?.results {
                self.items = results
            }
        }
    }
    
    func setSelectorViewCollapsed(_ collapsed: Bool, animated: Bool) {
        let height = collapsed ? SectionsSelectorView.collapsedHeight : SectionsSelectorView.regularHeight
        if (animated) {
            UIView.animate(withDuration: 0.5) {
                self.sectionsSelectorHeightConstraint.constant = height
                self.view.layoutIfNeeded()
            }
        } else {
            self.sectionsSelectorHeightConstraint.constant = height
            self.view.layoutIfNeeded()
        }
        
    }
}

extension HomeViewController : SectionSelectorDelegate {
    func didToggleCollapse(_ sectionSelectorView: SectionsSelectorView, collapsed: Bool) {
        setSelectorViewCollapsed(collapsed, animated: true)
    }
    
    func didChangeSection(_ sectionSelectorView: SectionsSelectorView, itemType: ItemType, categoryType: CategoryType) {
            print("Did Change value")
    }
}



