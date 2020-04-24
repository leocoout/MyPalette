//
//  SavedColorsEmptyView.swift
//  MyPalette
//
//  Created by Leonardo Santos on 16/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class SavedColorsEmptyView: UIView {
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.alignment = .leading
        
        return stack
    }()

    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .customBlack
        label.text = "You don't have any saved colors yet :("
        
        return label
    }()
    
    private lazy var startNowButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.style = .inverted
        button.setTitle("GO BACK", for: .normal)
        button.addTarget(self, action: #selector(didTapStartNowButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    public var buttonAction: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()        
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
        
        startNowButton.widthAnchor.constraint(equalToConstant: 142).isActive = true
        
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(startNowButton)
    }
    
    @objc private func didTapStartNowButton() {
        buttonAction?()
    }
}
