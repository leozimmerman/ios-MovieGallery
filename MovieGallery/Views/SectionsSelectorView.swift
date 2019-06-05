//
//  SectionsSelectorView.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 05/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

protocol SectionSelectorDelegate: class {
    func didToggleCollapse(_ sectionSelectorView: SectionsSelectorView, collapsed: Bool)
    func didChangeSection(_ sectionSelectorView: SectionsSelectorView, itemType: ItemType, categoryType: CategoryType)
}

class SectionsSelectorView: UIView {
    
    static let collapsedHeight: CGFloat = 50.0
    static let regularHeight: CGFloat = 200.0
    
    weak var delegate: SectionSelectorDelegate?

    @IBOutlet private var contentView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var arrowImage: UIImageView!
    @IBOutlet private var pickerView: UIPickerView! {
        didSet {
            pickerView.delegate = self
            pickerView.dataSource = self
        }
    }
    
    private(set) var isCollapsed: Bool = true
    private var selectedItemType: ItemType = .movie {
        didSet {
            currentOptions = {
                switch selectedItemType {
                case .movie:
                    return moviesOptions
                case .tvShow:
                    return tvOptions
                }
            }()
        }
    }
    private var selectedCategoryType: CategoryType = .popular
    
    private let moviesOptions: [CategoryType] = [.popular, .topRated, .upcoming]
    private let tvOptions: [CategoryType] = [.popular, .topRated, .onTheAir]
    private var currentOptions = [CategoryType]()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("SectionsSelectorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        clipsToBounds = true
        
        currentOptions = moviesOptions
        updateTitleLabel()
    }
    // MARK: UI touches handling
    @IBAction func tapAreaTouchedUp(_ sender: Any) {
        toggleCollapse()
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        guard let segmentedControl = sender as? UISegmentedControl else { return }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectItemType(.movie)
        case 1:
            selectItemType(.tvShow)
        default:
            return
        }
    }
    
    private func toggleCollapse() {
        isCollapsed = !isCollapsed
        updateArrowOrientation()
        delegate?.didToggleCollapse(self, collapsed: isCollapsed)
    }
    
    private func selectItemType(_ itemType: ItemType) {
        selectedItemType = itemType
        pickerView.reloadAllComponents()
        pickerView.selectRow(0, inComponent: 0, animated: false)
        selectCategoryType(currentOptions[0])
        updateTitleLabel()
    }
    
    private func selectCategoryType(_ categoryType: CategoryType) {
        selectedCategoryType = categoryType
        updateTitleLabel()
        delegate?.didChangeSection(self, itemType: selectedItemType, categoryType: selectedCategoryType)
    }
    
    private func updateTitleLabel() {
        let title = selectedItemType.title() + " - " + selectedCategoryType.title()
        titleLabel.text = title
    }
    
    private func updateArrowOrientation() {
        let rotationAngle = isCollapsed ? 0.0 : CGFloat(Double.pi)
        UIView.animate(withDuration: 0.5) {
            self.arrowImage.transform = CGAffineTransform(rotationAngle: rotationAngle)
        }
    }
}

extension SectionsSelectorView : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = currentOptions[row].title()
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCategoryType(currentOptions[row])
    }
}

extension SectionsSelectorView : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentOptions.count
    }
}
