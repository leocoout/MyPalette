//
//  SavedColorsListView.swift
//  MyPalette
//
//  Created by Leonardo Santos on 17/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class SavedColorsListView: UIView {
    
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
        return collection
    }()
    
    var colorListItens = [MPKManagedObject]() {
        didSet {
            collectionView.reloadData()
        }
    }
       
    // MARK: Object Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        setupCollection()
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
        
        collectionView.register(SavedColorsListCell.self,
                                forCellWithReuseIdentifier: "SavedColorsListCell")
    }
    
}

extension SavedColorsListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorListItens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedColorsListCell",
                                                      for: indexPath) as! SavedColorsListCell
        
        cell.colorPicked = colorListItens[indexPath.row].value(forKey: "colorPicked") as? String
        
        return cell
    }
}


