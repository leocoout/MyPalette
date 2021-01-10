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
        let context = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: type.entity.rawValue, in: context) {
            let object = NSManagedObject(entity: entity, insertInto: context)
            
            type.data.forEach { (key, value) in
                object.setValue(value, forKey: key)
            }
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    static func recoverLocalData(of type: MPKLocalServiceType,
                                 appDelegate: AppDelegate?,
                                 completion: @escaping ([NSManagedObject]) -> ()) {
        guard let appDelegate = appDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: type.rawValue)
        
        do {
            let object = try context.fetch(fetchRequest)
            completion(object)
        } catch {
            print(error)
        }
    }
    
    static func removeObject(_ object: MPKManagedObject, appDelegate: AppDelegate?, completion: () -> Void) {
        guard let appDelegate = appDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        context.delete(object)
        
        do {
            try context.save()
            completion()
        } catch {
            print(error)
        }
    }
}
