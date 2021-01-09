//
//  HomeViewControllerServiceManager.swift
//  MyPalette
//
//  Created by Leonardo Santos on 22/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomeViewControllerServiceManager {
    
    static func saveData(model: ColorModel) {
        let data = HomeViewControllerBaseData(model: model)
        MyPaletteServiceAPI.saveLocalData(of: data)
    }
    
    static func recoverdata(completion: @escaping ([NSManagedObject]) -> ()) {
        MyPaletteServiceAPI.recoverLocalData(of: .color) { (recoveredData) in
            completion(recoveredData)
        }
    }
}
