//
//  HomePresenterTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class HomePresenterTests: XCTestCase {
    
    // MARK: Sut
    var presenter: HomePresenter?
    var view: HomeViewControllerMock!
    
    override func setUp() {
        super.setUp()
        presenter = HomePresenter()
        view = HomeViewControllerMock()
        
        presenter?.view = view
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
    }
    
    func test_handleCameraPermissionAuthorized_called() {
        presenter?.presentRequestAuthorized()
        XCTAssertTrue(view.handleCameraPermissionAuthorizedCalled)
    }
    
    func test_handleCameraPermissionUnauthorized_called() {
        presenter?.presentRequestUnauthorized()
        XCTAssertTrue(view.handleCameraPermissionUnauthorizedCalled)
    }
    
    func test_handleDataRecovered_called() {
        presenter?.presentDataRecovered(response: [])
        XCTAssertTrue(view.handleDataRecoveredCalled)
    }
    
    func test_handleCaptureAction_called() {
        presenter?.presentCapture()
        XCTAssertTrue(view.handleCaptureActionCalled)
    }
    
}
