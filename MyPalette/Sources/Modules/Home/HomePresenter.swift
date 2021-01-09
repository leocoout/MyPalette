//
//  HomePresenter.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol {
    func presentRequestAuthorized()
    func presentRequestUnauthorized()
    func presentDataRecovered(response: [MPKManagedObject])
    func presentCapture()
}

class HomePresenter {
    
    // MARK: Properties
    weak var view: HomeViewControllerProtocol?
}

extension HomePresenter: HomePresenterProtocol {
    func presentRequestAuthorized() {
        view?.handleCameraPermissionAuthorized()
    }
    
    func presentRequestUnauthorized() {
        view?.handleCameraPermissionUnauthorized()
    }
    
    func presentDataRecovered(response: [MPKManagedObject]) {
        view?.handleDataRecovered(response: response)
    }
    
    func presentCapture() {
        view?.handleCaptureAction()
    }
}
