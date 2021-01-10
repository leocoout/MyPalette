//
//  SavedColorsViewModel.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

protocol SavedColorsViewModelProtocol {
    func setData(_ data: [MPKManagedObject])
    func getItemAt(indexPath: IndexPath) -> MPKManagedObject
    func numberOfSections() -> Int
    func numberOfRows(at section: Int) -> Int
}
 
class SavedColorsListViewModel: SavedColorsViewModelProtocol {
    
    private var data: [MPKManagedObject] = []
    
    func setData(_ data: [MPKManagedObject]) {
        self.data = data
    }
    
    func getItemAt(indexPath: IndexPath) -> MPKManagedObject {
        return data[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(at section: Int) -> Int {
        return data.count
    }
}
