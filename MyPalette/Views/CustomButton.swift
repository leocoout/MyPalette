//
//  CustomButton.swift
//  MyPalette
//
//  Created by Leonardo Santos on 12/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

enum CustomButtonStyles {
    case normal, inverted
}

class CustomButton: UIButton {

    var style: CustomButtonStyles = .normal {
        didSet {
            updateButtonStyle()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        frame.size.height = 48
    }
    
    private func updateButtonStyle() {
        switch style {
        case .normal:
            backgroundColor = .white
            setTitleColor(.customBlack, for: .normal)
        case .inverted:
            backgroundColor = .customBlack
            setTitleColor(.white, for: .normal)
        }
    }
}
