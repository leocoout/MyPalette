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

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        layer.cornerRadius = 16
    }
}
