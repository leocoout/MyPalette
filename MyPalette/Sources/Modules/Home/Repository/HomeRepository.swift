//
//  HomeRepository.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

protocol HomeRepositoryProtocol {
    func recoverdata(completion: @escaping ([MPKManagedObject]) -> ())
}

class HomeRepository: HomeRepositoryProtocol {
    
    static func saveData(model: ColorModel) {
        let data = HomeViewControllerBaseData(model: model)
        MPKLocalService.saveLocalData(of: data)
    }
    
    func recoverdata(completion: @escaping ([MPKManagedObject]) -> ()) {
        MPKLocalService.recoverLocalData(of: .color) { (recoveredData) in
            completion(recoveredData)
        }
    }
}
