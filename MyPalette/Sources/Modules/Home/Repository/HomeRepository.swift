//
//  HomeRepository.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRepositoryProtocol {
    func saveData(model: ColorModel)
    func recoverdata(completion: @escaping ([MPKManagedObject]) -> ())
    func deleteObject(_ object: MPKManagedObject, completion: () -> Void)
}

class HomeRepository: HomeRepositoryProtocol {
    
    var localService: MPKLocalService
    
    public init(localService: MPKLocalService) {
        self.localService = localService
    }
    
    private static var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func saveData(model: ColorModel) {
        let data = HomeViewControllerBaseData(model: model)
        localService.saveLocalData(of: data, appDelegate: Self.appDelegate)
    }
    
    func recoverdata(completion: @escaping ([MPKManagedObject]) -> ()) {
        localService.recoverLocalData(of: .color, appDelegate: Self.appDelegate) { recoveredData in
            completion(recoveredData)
        }
    }
    
    func deleteObject(_ object: MPKManagedObject, completion: () -> Void) {
        localService.removeObject(object, appDelegate: Self.appDelegate) {
            completion()
        }
    }
}
