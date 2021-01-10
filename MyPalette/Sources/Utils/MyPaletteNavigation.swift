//
//  MyPaletteNavigation.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class MyPaletteNavigation {
    
    /// Use this method to create flows with navigation controllers, for example, show a modal navigation controller
    /// - Parameter controller: a optional view controller
    /// - Parameter title: set the title of the navigation controller
    /// - Returns: returns a UINavigationController
    /// ```
    /// // Usage
    /// // 1. let flow = MyPaletteNavigation.createFlow(using: customView)
    /// // 2. present(flow, animated: true, completion: nil)
    /// ```
    static func createFlow(using controller: UIViewController?, title: String? = nil) -> UINavigationController {
        
        guard let controller = controller else { return UINavigationController() }
        
        let nav = UINavigationController.init(rootViewController: controller)
        nav.navigationBar.topItem?.title = title
        
        return nav
    }
}
