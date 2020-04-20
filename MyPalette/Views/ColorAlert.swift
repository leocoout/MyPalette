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
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeAlertGesture(_:))))
        
        return view
    }()
    
    private lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandAlert(_:))))
        
        return view
    }()
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyColorToClipboard(_:))))
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .myPalleteGray
        button.addTarget(self, action: #selector(closeAlertGesture(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .myPalleteGray
        button.addTarget(self, action: #selector(expandAlert), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var saveButton: AlertButton = {
        let button = AlertButton()
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: ColorAlertDelegate?
    private var colorViewHeight = NSLayoutConstraint()
    private let titleLabel = UILabel()
    private let tipLabel = UILabel()
    private var alertHeightConstraint = NSLayoutConstraint()
    
    var colorPicked: UIColor = .black  {
        didSet {
            updateColorView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        background.frame = bounds
    }
}

// MARK: - Private methods
extension ColorAlert {
    
    private func setup() {
        isHidden = true
        addSubview(background)
        
        setupAlertViewLayout()
        setupAlertViewContent()
    }
    
    private func setupAlertViewLayout() {
        addSubview(alertView)
    
        colorViewHeight = alertView.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            colorViewHeight,
            alertView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            alertView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            alertView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                              constant: 64 + 16 + 8),
        ])
        
    }
    
    private func setupAlertViewContent() {
        alertView.addSubview(colorView)
        alertView.addSubview(stackView)
        alertView.addSubview(closeButton)
        alertView.addSubview(expandButton)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            colorView.leftAnchor.constraint(equalTo: alertView.leftAnchor, constant: 16),
            colorView.heightAnchor.constraint(equalToConstant: 48),
            colorView.widthAnchor.constraint(equalToConstant: 48),
        
            stackView.centerYAnchor.constraint(equalTo: colorView.centerYAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: colorView.rightAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: 0),
            
            closeButton.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            closeButton.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0),
            closeButton.rightAnchor.constraint(equalTo: alertView.rightAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            
            expandButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            expandButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -8),
            expandButton.heightAnchor.constraint(equalToConstant: 20),
            expandButton.widthAnchor.constraint(equalToConstant: 18),
        ])
        
        tipLabel.text = "Tap to more actions"
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
        background.isUserInteractionEnabled = true
        isHidden = false
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 20, options: .curveEaseInOut, animations: { [weak self] in
                self?.background.alpha = 0.8
                self?.alertView.transform = CGAffineTransform(translationX: 0, y: -(64 + 32 + 8))
                }, completion: nil)
        }
    }
    
    private func hideAlert() {
        background.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                self?.background.alpha = 0
                self?.alertView.transform = .identity
                }, completion: { _ in
                    self.isHidden = true
            })
        }
    }
    
    
    private func updateAlertHeightAnimated() {
        colorViewHeight.constant = 166
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: - Actions
extension ColorAlert {
    
    @objc private func closeAlertGesture(_ gesture: UITapGestureRecognizer) {
        delegate?.alertDidClose()
        hideAlert()
    }
    
    @objc private func copyColorToClipboard(_ gesture: UITapGestureRecognizer) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = titleLabel.text
    }
    
    @objc private func expandAlert(_ gesture: UITapGestureRecognizer) {
        updateAlertHeightAnimated()
    }
}
