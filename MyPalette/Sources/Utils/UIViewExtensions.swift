//
//  UIViewExtensions.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(color: UIColor = .customBlack, offset: CGSize = .zero, opacity: Float = 0.15, radius: CGFloat = 8) {
        layer.shadowColor = UIColor.customBlack.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 8
    }
}
