//
//  ColorAlert.swift
//  MyPalette
//
//  Created by Leonardo Santos on 12/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class ColorAlert: UIView {
    
    // MARK: Properties
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    
    var colorViewBackground: CALayer?
    var colorPicked: UIColor = .black  {
        didSet {
            updateColorView()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAlertViewLayout()
        setupAlertViewContent()
    }
    
    private func setupAlertViewLayout() {
        addSubview(alertView)
        
        alertView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                          constant: 64 + 16 + 8).isActive = true
        alertView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        alertView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        alertView.heightAnchor.constraint(equalToConstant: 86).isActive = true
    }
    
    private func setupAlertViewContent() {
        alertView.addSubview(colorView)
        
        colorView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor, constant: 0).isActive = true
        colorView.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 16).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        alertView.addSubview(stackView)
    
        stackView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: colorView.rightAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -16).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = "#FFFFF"
        titleLabel.textColor = .customBlack
        
        let tipLabel = UILabel()
        tipLabel.text = "Toque para salvar"
        tipLabel.textColor = .customBlack
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(tipLabel)
    }
    
    private func updateColorView() {
        colorView.backgroundColor = colorPicked
    }
    
    func showAlert() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveEaseInOut, animations: { [weak self] in
            self?.alertView.transform = CGAffineTransform(translationX: 0, y: -(64 + 32 + 8))
        }, completion: nil)
    }
    
    func hideAlert() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.alertView.transform = .identity
        }, completion: nil)
    }
}
