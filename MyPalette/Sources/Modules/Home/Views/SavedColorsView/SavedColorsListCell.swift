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
    
    // MARK: Properties
    var colorPicked: String? = "0 0 0 1" {
        didSet {
            updateColorView()
        }
    }
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_delete"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.isHidden = true
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
        addShadow(offset: CGSize(width: 0, height: 5))
        setupIconImageView()
    }
    
    public func showTrashIcon() {
        icon.isHidden = false
    }
    
    public func hideTrashIcon() {
        icon.isHidden = true
    }
}

// MARK: Private Methods
extension SavedColorsListCell {
    private func setupIconImageView() {
        contentView.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 16),
            icon.widthAnchor.constraint(equalToConstant: 16),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func updateColorView() {
        if let color = colorPicked {
            backgroundColor = MPKColorEngine.colorSpaceToUIColor(value: color)
        }
    }
}
