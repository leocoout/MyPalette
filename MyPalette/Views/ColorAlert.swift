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

enum ColorCardState {
    case expand, collapse
    
    func toggle() -> ColorCardState {
        switch self {
        case .expand: return .collapse
        case .collapse: return .expand
        }
    }
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
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var colorCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeColorCardState(_ :))))
        
        return view
    }()
    
    private lazy var colorPickedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyColorToClipboard(_:))))
        
        return view
    }()
    
    private lazy var colorCardStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "#FFFFFF"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .customBlack
        
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to see more"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .customBlack
        
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_close"), for: .normal)
        button.addTarget(self, action: #selector(closeAlertGesture(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_arrow_down"), for: .normal)
        button.addTarget(self, action: #selector(changeColorCardState(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: ColorAlertDelegate?
    private var colorViewHeight = NSLayoutConstraint()
    private var colorCardState: (state: ColorCardState, animated: Bool) = (.collapse, animated: false) {
        didSet {
            updateAlertHeight(animated: colorCardState.animated)
        }
    }
    
    var colorPicked: UIColor = .black {
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
//        colorCardState = (state: .collapse, animated: false)
    }
}

// MARK: - 
extension ColorAlert {
    func showAlert() {
        isHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.background.alpha = 0.8
            self.stackView.transform = CGAffineTransform(translationX: 0, y: -(100 + 32))
        }, completion: nil)
    }
    
    func hideAlert() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.background.alpha = 0
            self.stackView.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: { _ in
            self.isHidden = true
        })
    }
}

// MARK: - Private methods
extension ColorAlert {
    
    private func setup() {
        isHidden = true
        addSubview(background)
        setupStackView()
        setupColorCardView()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                              constant: (16 + 100)),
        ])
    }
    
    private func setupColorCardView() {
        stackView.addArrangedSubview(colorCardView)
        colorViewHeight = colorCardView.heightAnchor.constraint(equalToConstant: 100)
        colorViewHeight.isActive = true
        
        colorCardView.addSubview(colorPickedView)
        colorCardView.addSubview(colorCardStackView)
        colorCardView.addSubview(closeButton)
        colorCardView.addSubview(expandButton)
        
        NSLayoutConstraint.activate([
            colorPickedView.leftAnchor.constraint(equalTo: colorCardView.leftAnchor, constant: 16),
            colorPickedView.topAnchor.constraint(equalTo: colorCardView.topAnchor, constant: 16),
            colorPickedView.heightAnchor.constraint(equalToConstant: 48),
            colorPickedView.widthAnchor.constraint(equalToConstant: 48),
            
            colorCardStackView.leftAnchor.constraint(equalTo: colorPickedView.rightAnchor, constant: 16),
            colorCardStackView.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: 0),
            colorCardStackView.centerYAnchor.constraint(equalTo: colorPickedView.centerYAnchor),
            
            closeButton.rightAnchor.constraint(equalTo: colorCardView.rightAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: colorCardView.topAnchor, constant: 16),
            closeButton.leftAnchor.constraint(equalTo: colorCardStackView.rightAnchor, constant: 0),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),

            expandButton.widthAnchor.constraint(equalToConstant: 18),
            expandButton.heightAnchor.constraint(equalToConstant: 18),
            expandButton.centerXAnchor.constraint(equalTo: colorCardView.centerXAnchor),
            expandButton.bottomAnchor.constraint(equalTo: colorCardView.bottomAnchor, constant: -8)
        ])
        
        colorCardStackView.addArrangedSubview(titleLabel)
        colorCardStackView.addArrangedSubview(bodyLabel)
    }

    private func updateAlertHeight(animated: Bool) {
        colorViewHeight.constant = colorCardState.state == .expand ? 166 : 100
        UIView.animate(withDuration: 0.2) {
            self.expandButton.transform = self.expandButton.transform.rotated(by: .pi)
            self.layoutIfNeeded()
        }
    }
    
    private func updateColorView() {
        colorPickedView.backgroundColor = colorPicked
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
//        pasteboard.string = titleLabel.text
    }
    
    @objc private func changeColorCardState(_ gesture: UITapGestureRecognizer) {
        colorCardState = (state: colorCardState.0.toggle(), animated: true)
    }
}
