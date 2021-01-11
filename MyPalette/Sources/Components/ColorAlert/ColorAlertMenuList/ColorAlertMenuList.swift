//
//  ColorAlertMenu.swift
//  MyPalette
//
//  Created by Leonardo Santos on 20/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol ColorAlertMenuListDelegate: class {
    func didTapCopyItem()
    func didTapSaveItem()
}

/// This class is responsible for the itens list that shows up with the Color Alert card
class ColorAlertMenuList: UIView {
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 16
        
        return stack
    }()
    
    private lazy var copyButton = ColorAlertListItem()
    private lazy var saveButton = ColorAlertListItem()
    private lazy var spacing = UIView()
    weak var delegate: ColorAlertMenuListDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.frame = bounds
        
        copyButton.titleLabel.text = "Copiar"
        saveButton.titleLabel.text = "Salvar"
        
        copyButton.action = { self.delegate?.didTapCopyItem() }
        saveButton.action = { self.delegate?.didTapSaveItem() }
        
        stackView.addArrangedSubview(copyButton)
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(spacing)
        
        [copyButton, saveButton].forEach {
            NSLayoutConstraint.activate([$0.widthAnchor.constraint(equalToConstant: 42)])
            $0.alpha = 0
            $0.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }
    }
    
    public func showItens() {
        var delay: Double = 0.05
        
        DispatchQueue.main.async {
            for item in [self.copyButton, self.saveButton] {
                delay += 0.1
                UIView.animate(withDuration: 0.3, delay: delay, usingSpringWithDamping: 0.8, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
                    item.alpha = 1
                    item.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }
    
    public func hideItens() {
        var delay: Double = 0.1
        DispatchQueue.main.async {
            for item in [self.saveButton, self.copyButton] {
                delay += 0.1
                UIView.animate(withDuration: 0.3, delay: delay, animations: {
                    item.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    item.alpha = 0
                }, completion: nil)
            }
        }
    }
}
