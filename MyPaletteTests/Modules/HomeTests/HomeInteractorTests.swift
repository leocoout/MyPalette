//
//  HomeInteractorTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class HomeInteractorTests: XCTestCase {

    // MARK: Sut
    var interactor: HomeInteractor?
    var presenter: HomePresenterMock!
    var permissions: MPKPermissionsMock!
    
    override func setUp() {
        super.setUp()
        permissions = MPKPermissionsMock()
        interactor = HomeInteractor(
            repository: HomeRepositoryMock(),
            permissions: permissions
        )
        
        presenter = HomePresenterMock()
        
        interactor?.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
    }
    
    func test_presentRequestAuthorized_called() {
        permissions.requestCameraPermissionResponse = true
        interactor?.requestCameraPermission()
        XCTAssertTrue(presenter.presentRequestAuthorizedCalled)
        XCTAssertFalse(presenter.presentRequestUnauthorizedCalled)
    }
    
    func test_presentRequestUnauthorized_called() {
        permissions.requestCameraPermissionResponse = false
        interactor?.requestCameraPermission()
        XCTAssertTrue(presenter.presentRequestUnauthorizedCalled)
        XCTAssertFalse(presenter.presentRequestAuthorizedCalled)
    }
    
    func test_presentDataRecovered_called() {
        interactor?.fetchColorData()
        XCTAssertTrue(presenter.presentDataRecoveredCalled)
    }
    
    func test_presentCapture_called() {
        interactor?.didCapture()
        XCTAssertTrue(presenter.presentCaptureCalled)
    }
}
