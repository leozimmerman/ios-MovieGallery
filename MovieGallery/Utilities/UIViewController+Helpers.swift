//
//  UIViewController+Helpers.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 11/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
