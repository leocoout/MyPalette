//
//  MPKManagedObject.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    /// Get color picked object from local storage
    /// - Returns: returns a string like `0 0 0 1`
    func getColorPicked() -> String? {
        return value(forKey: MPKManagedObjectKeys.colorPicked.rawValue) as? String
    }
    
}
