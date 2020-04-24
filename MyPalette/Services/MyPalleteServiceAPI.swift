//
//  MyPalleteServiceAPI.swift
//  MyPalette
//
//  Created by Leonardo Santos on 22/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum MyPalleteServiceAPIType: String {
    case color = "Color"
}

protocol BaseData {
    var entity: MyPalleteServiceAPIType { get }
    var `data`: [String: Any?] { get }
}

class MyPalleteServiceAPI {

    static func saveLocalData(of type: BaseData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
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
    
    static func recoverLocalData(of type: MyPalleteServiceAPIType,
                                 completion: @escaping ([NSManagedObject]) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
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
