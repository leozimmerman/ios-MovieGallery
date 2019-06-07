//
//  SearchViewController.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 05/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }
    
    private var allItems: [Item]?
    private var filteredItems: [Item]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allItems = StorageManager.shared.allStoredItems
    }
    
    func filterItems(withText text: String) {
        filteredItems = allItems?.filter({ (item) -> Bool in
            item.name.lowercased().contains(text.lowercased())
        })
        tableView.reloadData()
    }
    
    func presentDetailViewController(with item: Item) {
        let vc = DetailViewController.create(with: item)
        present(vc, animated: true, completion: nil)
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems(withText: searchText)
    }
}

extension SearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = filteredItems?[indexPath.row] else { return }
        presentDetailViewController(with: item)
    }
}

extension SearchViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "defaultCell")
        }
        cell.textLabel?.text = filteredItems?[indexPath.row].name
        return cell
    }
}
