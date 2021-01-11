//
//  HomeInteractor.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol HomeInteractorProtocol {
    func requestCameraPermission()
    func saveData(color: UIColor?)
    func fetchColorData()
    func removeObject(_ object: MPKManagedObject)
    func didCapture()
}

class HomeInteractor {
    
    // MARK: Properties
    var presenter: HomePresenterProtocol?
    var permissions: MPKPermissions
    var repository: HomeRepositoryProtocol?
    
    init(repository: HomeRepositoryProtocol?, permissions: MPKPermissions) {
        self.repository = repository
        self.permissions = permissions
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func requestCameraPermission() {
        permissions.requestCameraPermission { response in
            response ?
                self.presenter?.presentRequestAuthorized() :
                self.presenter?.presentRequestUnauthorized()
        }
    }
    
    func fetchColorData() {
        repository?.recoverdata { (response) in
            self.presenter?.presentDataRecovered(response: response)
        }
    }
    
    func removeObject(_ object: MPKManagedObject) {
        repository?.deleteObject(object, completion: {
            print("deletado")
        })
    }
    
    func saveData(color: UIColor?) {
        guard let modelColor = color else { return }
        let model = ColorModel(color: modelColor)
        repository?.saveData(model: model)
    }
    
    func didCapture() {
        presenter?.presentCapture()
    }
}
