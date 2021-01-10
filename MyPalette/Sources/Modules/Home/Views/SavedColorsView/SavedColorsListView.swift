//
//  SavedColorsListView.swift
//  MyPalette
//
//  Created by Leonardo Santos on 17/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol SavedColorsListViewDelegate: class {
    func didSelectItem(with data: MPKManagedObject)
    func didDeletedItem(_ item: MPKManagedObject)
    func didEnteredDeletionMode()
    func didLeftDeletionMode()
}

class SavedColorsListView: UIView {
    
    // MARK: Private Lazy Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 86, height: 86)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceHorizontal = true
        return collection
    }()
    
    // MARK: Properties
    lazy var viewModel: SavedColorsViewModelProtocol = SavedColorsListViewModel()
    weak var delegate: SavedColorsListViewDelegate?
    var colorListItens = [MPKManagedObject]() {
        didSet {
            viewModel.setData(colorListItens)
            collectionView.reloadData()
        }
    }
       
    // MARK: Object Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        setupCollection()
    }
    
    public func leftDeletionMode() {
        self.delegate?.didLeftDeletionMode()
        viewModel.setDeleteMode(to: false)
        collectionView.reloadData()
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellClass: SavedColorsListCell.self)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        collectionView.addGestureRecognizer(longPress)
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            viewModel.setDeleteMode(to: true)
            self.delegate?.didEnteredDeletionMode()
            collectionView.reloadData()
        }
    }
}

extension SavedColorsListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SavedColorsListCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.colorPicked = viewModel.getItemAt(indexPath: indexPath).getColorPicked()
        cell.trashIconVisibility(hidden: !viewModel.deleteModeIsEnabled())
        if viewModel.deleteModeIsEnabled() {
            cell.shake()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.deleteModeIsEnabled() {
            self.collectionView.performBatchUpdates({
                self.delegate?.didDeletedItem(viewModel.getItemAt(indexPath: indexPath))
                viewModel.deleteItemAt(indexpath: indexPath)
                self.collectionView.deleteItems(at: [indexPath])
            }, completion:nil)
        } else {
            delegate?.didSelectItem(with: viewModel.getItemAt(indexPath: indexPath))
        }
    }
}
