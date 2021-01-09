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
    func didCapture()
}

class HomeInteractor {
    
    // MARK: Properties
    var presenter: HomePresenterProtocol?
    var repository: HomeRepositoryProtocol?
    
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
        HomeViewControllerServiceManager.recoverdata { (response) in
            self.presenter?.presentDataRecovered(response: response)
        }
    }
    
    func didCapture() {
        presenter?.presentCapture()
    }
}
