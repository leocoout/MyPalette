//
//  SavedColorsView.swift
//  MyPalette
//
//  Created by Leonardo Santos on 15/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum SavedColorsViewState {
    case empty, loaded
}

protocol SavedColorsDelegate: class {
    func didTapEmptyStateButton()
}

class SavedColorsView: UIView {
    
    // MARK: Properties
    weak var delegate: SavedColorsDelegate?
    private lazy var emptyView = SavedColorsEmptyView()
    private lazy var listView = SavedColorsListView()
    
    var itens = [NSManagedObject]() {
        didSet {
            updateColorList()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .customBlack
        label.text = "My Colors"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTitleLayout()
    }
    
    func setupWith(state: SavedColorsViewState) {
        switch state {
        case .empty: setupAndShowEmptyView()
        case .loaded: setupAndShowContentView()
        }
    }
    
    private func setupTitleLayout() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
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
}
