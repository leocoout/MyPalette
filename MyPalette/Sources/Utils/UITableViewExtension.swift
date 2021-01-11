//
//  UITableViewExtension.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register(classForNib: AnyClass) {
        let identifier = identifierForClass(classForNib)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = identifierForClass(T.self)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    private func identifierForClass(_ class: AnyClass) -> String {
        return String(describing: `class`)
    }
}
