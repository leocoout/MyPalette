//
//  ShadowCard.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ShadowCard: UIView {
    
    @IBInspectable var allowShadow: Bool = true
    @IBInspectable var borderRadius: CGFloat = 8 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}

// MARK: - Private Methods
extension ShadowCard {
    private func setupLayout() {
        layer.cornerRadius = borderRadius
        layer.shadowColor = UIColor.customBlack.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.15
        layer.shadowRadius = 8
    }
}
