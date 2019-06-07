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
    @IBOutlet private var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    private var items: [Item]?
    private var currentItemType: ItemType = .movie
    private var currentCategoryType: CategoryType = .popular

    //MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectorViewCollapsed(sectionsSelectorView.isCollapsed, animated: false)
        fetchData()
        let movie = StorageManager.shared.loadMoviesPage(itemType: currentItemType, categoryType: currentCategoryType)
        
    }
    
    func fetchData(){
        //TODO: Call StoreManager
        APIManager.shared.fetchPage(with: currentItemType, categoryType: currentCategoryType) { (page) in
            DispatchQueue.main.async {
                if let p = page {
                    self.loadPage(p)
                }
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
    
    func loadPage(_ page: Page) {
        StorageManager.shared.savePage(page, categoryType: currentCategoryType)
        items = page.items as? [Item]
        collectionView.reloadData()
    }
    
    func presentDetailViewController(with item: Item) {
        let vc = DetailViewController.create(with: item)
        present(vc, animated: true, completion: nil)
    }
}

//MARK: - Section Selector delegate
extension HomeViewController : SectionSelectorDelegate {
    func didToggleCollapse(_ sectionSelectorView: SectionsSelectorView, collapsed: Bool) {
        setSelectorViewCollapsed(collapsed, animated: true)
    }
    
    func didChangeSection(_ sectionSelectorView: SectionsSelectorView, itemType: ItemType, categoryType: CategoryType) {
        currentItemType = itemType
        currentCategoryType = categoryType
        fetchData()
    }
}

//MARK: - UICollectionView delegates
extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width / 2, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = items?[indexPath.item] else { return }
        presentDetailViewController(with: item)
    }
}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        if let item = items?[indexPath.item] {
            cell.setup(with: item)
        }
        return cell
    }
}



