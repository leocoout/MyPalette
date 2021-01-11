//
//  DetailsViewControllerHeaderCell.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import UIKit

class DetailsViewControllerHeaderCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var colorView: ShadowCard!
    @IBOutlet weak var colorCode: UILabel!

    func setup(with color: UIColor, hexadecimal: String) {
        colorView.backgroundColor = color
        colorCode.text = hexadecimal
    }
}
