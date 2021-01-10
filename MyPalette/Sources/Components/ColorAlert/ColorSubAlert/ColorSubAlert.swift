//
//  ColorSubAlert.swift
//  MyPalette
//
//  Created by Leonardo Santos on 20/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class ColorSubAlert: UIView {
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.spacing = 8
        
        return stack
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_copy_to_clipboard"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cor copiada com sucesso!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
        backgroundColor = .myPaletteGreen
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            icon.widthAnchor.constraint(equalToConstant: 18)
        ])
        
        
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(titleLabel)
    }
}
