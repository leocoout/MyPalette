//
//  SavedColorsListCell.swift
//  MyPalette
//
//  Created by Leonardo Santos on 17/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class SavedColorsListCell: UICollectionViewCell {
    
    var colorPicked: String? = "0 0 0 1" {
        didSet {
            updateColorView()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16

    }
    
    private func updateColorView() {
        if let color = colorPicked {
            backgroundColor = MyPaletteColorAPI.colorSpaceToUIColor(value: color)
        }
    }
}
