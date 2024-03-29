//
//  SearchViewController.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 05/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet var sectionsSelectorView: SectionsSelectorView! {
        didSet {
            sectionsSelectorView.delegate = self
        }
    }
    @IBOutlet var sectionsSelectorHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }
    
    private var itemsToFilter: [Item]?
    private var filteredItems: [Item]?
    private var filterActivated: Bool = false
    private var currentItemType: ItemType = .movie
    private var currentCategoryType: CategoryType = .popular
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSearchRange()
        setSelectorViewCollapsed(sectionsSelectorView.isCollapsed, animated: false)
        setSelectorViewHidden(!filterActivated, animated: false)
        setupHideKeyboardOnTap()
    }

    // MARK: Action handlers
    @IBAction func filterSwitchValueChanged(_ sender: Any) {
        let filterSwitch = sender as! UISwitch
        filterActivated = filterSwitch.isOn
        setSelectorViewHidden(!filterActivated, animated: true)
        updateSearchRange()
    }
    
    // MARK: Navigation
    private func presentDetailViewController(with item: Item) {
        let vc = DetailViewController.create(with: item)
        present(vc, animated: true, completion: nil)
    }
}

// MARK: Items Search
private extension SearchViewController {
    func filterItems(withText text: String) {
        if let items = itemsToFilter {
            filteredItems = ItemsFilter.filterItems(items, withText: text)
        } else {
            filteredItems = nil
        }
        tableView.reloadData()
    }
    
    func updateSearchRange() {
        itemsToFilter = filterActivated ? StorageManager.getItems(with: currentItemType, categoryType: currentCategoryType) : StorageManager.allStoredItems
        if let text = searchBar.text, text != "" {
            filterItems(withText: text)
        }
    }
}

// MARK: SelectorView Height modifying
private extension SearchViewController {
    func setSelectorViewHidden(_ hidden: Bool, animated: Bool) {
        if hidden {
            setSelectorViewHeight(height: 0.0, animated: hidden)
        } else {
            setSelectorViewCollapsed(sectionsSelectorView.isCollapsed, animated: animated)
        }
    }
    
    func setSelectorViewCollapsed(_ collapsed: Bool, animated: Bool) {
        let height = collapsed ? SectionsSelectorView.collapsedHeight : SectionsSelectorView.regularHeight
        setSelectorViewHeight(height: height, animated: animated)
    }
    
    func setSelectorViewHeight(height: CGFloat, animated: Bool) {
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

// MARK: - Section Selector delegate
extension SearchViewController : SectionSelectorDelegate {
    func didToggleCollapse(_ sectionSelectorView: SectionsSelectorView, collapsed: Bool) {
        setSelectorViewCollapsed(collapsed, animated: true)
    }
    
    func didChangeSection(_ sectionSelectorView: SectionsSelectorView, itemType: ItemType, categoryType: CategoryType) {
        currentItemType = itemType
        currentCategoryType = categoryType
        updateSearchRange()
    }
}

// MARK: - UISearchBar Delegate
extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems(withText: searchText)
    }
}
// MARK: - UITableView delegate
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell") ?? UITableViewCell(style: .default, reuseIdentifier: "DefaultCell")
        cell.textLabel?.text = filteredItems?[indexPath.row].displayTitle
        return cell
    }
}
