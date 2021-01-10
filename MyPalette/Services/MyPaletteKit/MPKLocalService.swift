//
//  MPKLocalService.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum MPKLocalServiceType: String {
    case color = "Color"
}

protocol MPKBaseData {
    var entity: MPKLocalServiceType { get }
    var `data`: [String: Any?] { get }
}

class MPKLocalService {

    static func saveLocalData(of type: MPKBaseData, appDelegate: AppDelegate?) {
        guard let appDelegate = appDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: type.entity.rawValue, in: managedContext) {
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            
            type.data.forEach { (key, value) in
                object.setValue(value, forKey: key)
            }
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    static func recoverLocalData(of type: MPKLocalServiceType,
                                 appDelegate: AppDelegate?,
                                 completion: @escaping ([NSManagedObject]) -> ()) {
        guard let appDelegate = appDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: type.rawValue)
        
        do {
            let object = try managedContext.fetch(fetchRequest)
            completion(object)
        } catch {
            print(error)
        }
    }
}
