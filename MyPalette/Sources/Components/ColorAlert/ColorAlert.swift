//
//  ColorAlert.swift
//  MyPalette
//
//  Created by Leonardo Santos on 12/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

enum ColorCardState {
    case expand, collapse
    
    func toggle() -> ColorCardState {
        switch self {
        case .expand: return .collapse
        case .collapse: return .expand
        }
    }
}

/// This class is responsible for the color alert that shows up when the capture is  completed. Can be used with `ColorAlertBuilder` class
class ColorAlert: UIView {
    
    // MARK: Configuration
    var config = ColorAlertConfigurator()
    
    // MARK: - Lazy Properties
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
        stack.spacing = 16
        
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
        label.text = "-"
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
    
    private lazy var colorCopiedImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_check"))
        view.alpha = 0
        
        return view
    }()
    
    private lazy var menuList = ColorAlertMenuList()
    private lazy var subAlertView = ColorSubAlert()
    
    // MARK: - Properties
    private var colorAlertCardHeight: CGFloat = 100
    private var colorSubAlertHeight: CGFloat = 48
    private var colorViewHeight = NSLayoutConstraint()
    private var stackViewBottomConstraint = NSLayoutConstraint()
    
    private var colorCardState: (state: ColorCardState, animated: Bool) = (.collapse, animated: false) {
        didSet {
            updateAlertHeight(animated: colorCardState.animated)
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
        menuList.delegate = self
        background.frame = bounds
        setupSubAlert()
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
        
        stackViewBottomConstraint = stackView.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor,
            constant: (32 + colorAlertCardHeight + colorSubAlertHeight)
        )
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackViewBottomConstraint
        ])
    }
    
    private func setupColorCardView() {
        stackView.addArrangedSubview(colorCardView)
        colorViewHeight = colorCardView.heightAnchor.constraint(equalToConstant: colorAlertCardHeight)
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
    
    private func setupSubAlert() {
        stackView.addArrangedSubview(subAlertView)
        subAlertView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setupColorCopiedMaskLayout() {
        colorCopiedImage.removeFromSuperview()
        colorPickedView.addSubview(colorCopiedImage)
        colorCopiedImage.frame.size = CGSize(width: 18, height: 18)
        colorCopiedImage.center = CGPoint(x: colorPickedView.frame.width / 2,
                                         y: colorPickedView.frame.height / 2)
        colorCopiedImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        animateColorCopiedImage()
    }
    
    private func animateColorCopiedImage() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 50,
            options: .curveEaseInOut,
            animations: {

                self.colorCopiedImage.alpha = 1
                self.colorCopiedImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseInOut, animations: {
                self.colorCopiedImage.alpha = 0
            }, completion: nil)
        }
    }

    private func updateAlertHeight(animated: Bool) {
        
        switch colorCardState.state {
        case .expand:
            colorViewHeight.constant = 166
            colorCardStackView.removeArrangedSubview(bodyLabel)
        case .collapse:
            colorViewHeight.constant = 100
            colorCardStackView.addArrangedSubview(bodyLabel)
            self.removeMenuListView()
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            self.bodyLabel.alpha = self.colorCardState.state == .expand ? 0 : 1
            self.expandButton.transform = self.expandButton.transform.rotated(by: .pi)
            self.layoutIfNeeded()
        }, completion: { _ in
            if self.colorCardState.state == .expand {
                self.insertMenuListView()
            }
        })
    }
    
    private func insertMenuListView() {
        colorCardView.addSubview(menuList)
        menuList.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuList.topAnchor.constraint(equalTo: colorPickedView.bottomAnchor, constant: 16),
            menuList.leftAnchor.constraint(equalTo: colorCardView.leftAnchor, constant: 16),
            menuList.rightAnchor.constraint(equalTo: colorCardView.rightAnchor, constant: -16),
            menuList.bottomAnchor.constraint(equalTo: expandButton.topAnchor, constant: -8)
        ])
        
        menuList.showItens()
    }
    
    private func removeMenuListView() {
        menuList.hideItens()
        menuList.removeFromSuperview()
    }
    
    private func updateColorView() {
        colorPickedView.backgroundColor = config.color
        titleLabel.text = MPKColorEngine.convertUIColorToString(using: config.color)
    }
    
    private func animateSubAlert() {
        stackViewBottomConstraint.constant -= colorSubAlertHeight + 16
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        }) { _ in
            
            self.stackViewBottomConstraint.constant += 16 + self.colorSubAlertHeight
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    private func performSaveAnimation() {
        let path = UIBezierPath()
        let viewCenter = colorPickedView.center
        let screenSize = UIScreen.main.bounds
        
        CATransaction.begin()
    
        path.move(to: CGPoint(x: viewCenter.x, y: viewCenter.y))
        path.addQuadCurve(to: CGPoint(x: screenSize.width / 2, y: screenSize.height),
                          controlPoint: CGPoint(x: screenSize.width / 2,
                                                y: -300))
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        
        animation.repeatCount = 0
        animation.duration = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        CATransaction.setCompletionBlock {
            self.closeAlertGesture(UITapGestureRecognizer())
        }
        
        colorPickedView.layer.add(animation, forKey: "animate along path")
        CATransaction.commit()
    }
}

// MARK: - Actions
extension ColorAlert {
    
    @objc private func closeAlertGesture(_ gesture: UITapGestureRecognizer) {
        config.closeAction?()
        hideAlert()
    }
    
    @objc private func copyColorToClipboard(_ gesture: UITapGestureRecognizer) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = titleLabel.text
        
        setupColorCopiedMaskLayout()
        animateSubAlert()
    }
    
    @objc private func changeColorCardState(_ gesture: UITapGestureRecognizer) {
        colorCardState = (state: colorCardState.0.toggle(), animated: true)
    }
}

// MARK: - Public Methods
extension ColorAlert {
    func showAlert() {
        colorPickedView.layer.removeAllAnimations()
        colorCardState = (state: .collapse, animated: false)
        isHidden = false
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.background.alpha = 0.8
            self.stackView.transform = CGAffineTransform(translationX: 0, y: -(self.colorAlertCardHeight + 32))
        }, completion: nil)
    }
    
    func hideAlert() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.background.alpha = 0
            self.stackView.transform = CGAffineTransform(translationX: 0, y: self.colorAlertCardHeight)
        }, completion: { _ in
            self.isHidden = true
        })
    }
}

// MARK: - ColorAlertMenuListDelegate
extension ColorAlert: ColorAlertMenuListDelegate {
    func didTapCopyItem() {
        copyColorToClipboard(UITapGestureRecognizer())
    }
    
    func didTapSaveItem() {
        performSaveAnimation()
        config.saveColorAction?(colorPickedView.backgroundColor)
    }
}
