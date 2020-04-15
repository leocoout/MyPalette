//
//  ColorAlert.swift
//  MyPalette
//
//  Created by Leonardo Santos on 12/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol ColorAlertDelegate: class {
    func alertDidClose()
}

class ColorAlert: UIView {
    
    // MARK: Properties
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAlertGesture(_:))))
        
        return view
    }()
    
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
    
    weak var delegate: ColorAlertDelegate?
    private let titleLabel = UILabel()
    var colorViewBackground: CALayer?
    var colorPicked: UIColor = .black  {
        didSet {
            updateColorView()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(background)
        background.frame = bounds
        
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
        
        let tipLabel = UILabel()
        tipLabel.text = "Toque para salvar"
        tipLabel.textColor = .customBlack
        tipLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        titleLabel.textColor = .customBlack
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(tipLabel)
    }
    
    private func updateColorView() {
        colorView.backgroundColor = colorPicked
        titleLabel.text = colorView.backgroundColor?.hexString()
    }
    
    func showAlert() {
        isUserInteractionEnabled = true
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 20, options: .curveEaseInOut, animations: { [weak self] in
                self?.background.alpha = 0.8
                self?.alertView.transform = CGAffineTransform(translationX: 0, y: -(64 + 32 + 8))
                }, completion: nil)
        }
    }
    
    private func hideAlert() {
        isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.background.alpha = 0
            self?.alertView.transform = .identity
        }, completion: nil)
    }
    
    @objc private func closeAlertGesture(_ gesture: UITapGestureRecognizer) {
        delegate?.alertDidClose()
        hideAlert()
    }
}
