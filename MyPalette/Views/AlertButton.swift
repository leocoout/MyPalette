//
//  AlertButton.swift
//  MyPalette
//
//  Created by Leonardo Santos on 18/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class AlertButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            updateButtonState()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        backgroundColor = .customBlack
        layer.cornerRadius = frame.height / 2
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    private func updateButtonState() {
        backgroundColor = isEnabled ? .customBlack : .myPalleteGray
    }
}
