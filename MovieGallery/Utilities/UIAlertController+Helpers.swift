//
//  UIAlertController+Helpers.swift
//  MovieGallery
//
//  Created by Leonardo Zimmerman on 10/06/2019.
//  Copyright © 2019 Leonardo Zimmerman. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func createErrorAlertController(withMessage message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Accept", style: .default))
        return alertController
    }
}
