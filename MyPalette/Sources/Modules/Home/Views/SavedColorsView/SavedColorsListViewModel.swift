//
//  SavedColorsViewModel.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol SavedColorsViewModelProtocol {
    func setData(_ data: [MPKManagedObject])
    func getData() -> [MPKManagedObject]
    func getItemAt(indexPath: IndexPath) -> MPKManagedObject
    func deleteItemAt(indexpath: IndexPath)
    func numberOfSections() -> Int
    func numberOfRows(at section: Int) -> Int
    func setDeleteMode(to bool: Bool)
    func deleteModeIsEnabled() -> Bool
}
 
class SavedColorsListViewModel: SavedColorsViewModelProtocol {
    
    private var data: [MPKManagedObject] = []
    private var deleteMode: Bool = false
    
    func setData(_ data: [MPKManagedObject]) {
        self.data = data
    }
    
    func getData() -> [MPKManagedObject]{
        return data
    }
    
    func getItemAt(indexPath: IndexPath) -> MPKManagedObject {
        return data[indexPath.row]
    }
    
    func deleteItemAt(indexpath: IndexPath) {
        data.remove(at: indexpath.row)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(at section: Int) -> Int {
        return data.count
    }
    
    func setDeleteMode(to bool: Bool) {
        if bool { UIImpactFeedbackGenerator(style: .medium).impactOccurred() }
        deleteMode = bool
    }
    
    func deleteModeIsEnabled() -> Bool {
        return deleteMode
    }
}
