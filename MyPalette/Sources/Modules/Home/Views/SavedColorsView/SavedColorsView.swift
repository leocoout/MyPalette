//
//  SavedColorsView.swift
//  MyPalette
//
//  Created by Leonardo Santos on 15/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol SavedColorsDelegate: class {
    func didTapEmptyStateButton()
    func didSelectItem(with data: MPKManagedObject)
    func didDeletedItem(_ item: MPKManagedObject)
}

class SavedColorsView: UIView {
    
    // MARK: Properties
    weak var delegate: SavedColorsDelegate?
    private lazy var emptyView = SavedColorsEmptyView()
    private lazy var listView = SavedColorsListView()
    
    var itens = [MPKManagedObject]() {
        didSet {
            updateColorList()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .customBlack
        label.text = "Minhas cores"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var button: CustomButton = {
        let button = CustomButton(type: .system)
        button.style = .inverted
        button.setTitle("CONCLUÍDO", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTitleLayout()
    }
    
    func setupWith(state: SavedColorsViewState) {
        switch state {
        case .empty: setupAndShowEmptyView()
        case .loaded: setupAndShowContentView()
        default: break
        }
    }
    
    private func setupTitleLayout() {
        addSubview(titleLabel)
        addSubview(button)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            button.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 24),
            button.heightAnchor.constraint(equalToConstant: 32),
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }

    private func setupAndShowEmptyView() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -16),
            emptyView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            emptyView.leftAnchor.constraint(equalTo: leftAnchor),
            emptyView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        emptyView.buttonAction = {
            self.delegate?.didTapEmptyStateButton()
        }
    }
    
    private func setupAndShowContentView() {
        emptyView.removeFromSuperview()
        addSubview(listView)
        listView.translatesAutoresizingMaskIntoConstraints = false
        listView.delegate = self
        
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            listView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            listView.leftAnchor.constraint(equalTo: leftAnchor),
            listView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func updateColorList() {
        listView.colorListItens = itens.reversed()
    }
    
    private func updateTitle(to title: String) {
        titleLabel.text = title
    }
    
    private func setButtonVisibility(hidden: Bool) {
        button.isHidden = hidden
    }
    
    @objc private func didTapActionButton() {
        listView.leftDeletionMode()
    }
}

extension SavedColorsView: SavedColorsListViewDelegate {
    func didSelectItem(with data: MPKManagedObject) {
        self.delegate?.didSelectItem(with: data)
    }
    
    func didDeletedItem(_ item: MPKManagedObject) {
        self.delegate?.didDeletedItem(item)
    }
    
    func didEnteredDeletionMode() {
        updateTitle(to: "Modo de exclusão")
        setButtonVisibility(hidden: false)
    }
    
    func didLeftDeletionMode() {
        updateTitle(to: "Minhas cores")
        setButtonVisibility(hidden: true)
    }
}
