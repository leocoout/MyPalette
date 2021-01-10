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
    func recoverdata(completion: @escaping ([MPKManagedObject]) -> ())
}

class HomeRepository: HomeRepositoryProtocol {
    
    private static var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    static func saveData(model: ColorModel) {
        let data = HomeViewControllerBaseData(model: model)
        MPKLocalService.saveLocalData(of: data, appDelegate: appDelegate)
    }
    
    func recoverdata(completion: @escaping ([MPKManagedObject]) -> ()) {
        MPKLocalService.recoverLocalData(of: .color, appDelegate: Self.appDelegate) { recoveredData in
            completion(recoveredData)
        }
    }
}
