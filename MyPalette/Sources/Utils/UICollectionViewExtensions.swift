//
//  UICollectionViewExtensions.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(cellClass: AnyClass) {
        let identifier = identifierForClass(cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    func register(classForNib: AnyClass) {
        let identifier = identifierForClass(classForNib)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = identifierForClass(T.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath ) as! T
    }
    
    private func identifierForClass(_ class: AnyClass) -> String {
        return String(describing: `class`)
    }
}
