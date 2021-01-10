//
//  HomeViewControllerMock.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class HomeViewControllerMock: HomeViewControllerProtocol {
    
    // MARK: Protocol Properties
    var interactor: HomeInteractorProtocol?
    var presenter: HomePresenterProtocol?
    
    // MARK: Properties
    var handleCameraPermissionAuthorizedCalled = false
    var handleCameraPermissionUnauthorizedCalled = false
    var handleDataRecoveredCalled = false
    var handleCaptureActionCalled = false
    
    func handleCameraPermissionAuthorized() {
        handleCameraPermissionAuthorizedCalled = true
    }
    
    func handleCameraPermissionUnauthorized() {
        handleCameraPermissionUnauthorizedCalled = true
    }
    
    func handleDataRecovered(response: [MPKManagedObject]) {
        handleDataRecoveredCalled = true
    }
    
    func handleCaptureAction() {
        handleCaptureActionCalled = true
    }

}
