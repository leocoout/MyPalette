//
//  UIViewControllerExtensions.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Custom initializer using our custom nib names
    /// - Parameters:
    ///   - nibName: MPNibs type. Usage: .home
    ///   - bundle: optional bundle
    convenience init(nibName: MPNibs, bundle: Bundle? = nil) {
        self.init(nibName: nibName.rawValue, bundle: bundle)
    }
}
