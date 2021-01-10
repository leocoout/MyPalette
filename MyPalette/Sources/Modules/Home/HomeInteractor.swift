//
//  HomeInteractor.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

protocol HomeInteractorProtocol {
    func requestCameraPermission()
    func fetchColorData()
    func removeObject(_ object: MPKManagedObject)
    func didCapture()
}

class HomeInteractor {
    
    // MARK: Properties
    var presenter: HomePresenterProtocol?
    var repository: HomeRepositoryProtocol? = HomeRepository()
    
    init(repository: HomeRepositoryProtocol?) {
        self.repository = repository
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func requestCameraPermission() {
        MPKPermissions.requestCameraPermission { response in
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
    
    func didCapture() {
        presenter?.presentCapture()
    }
}
