//
//  HomeViewControllerTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class HomeViewControllerTests: XCTestCase {
    
    // MARK: Sut
    var controller: HomeViewController?
    var interactor: HomeInteractorMock!
    
    override func setUp() {
        super.setUp()
        controller = HomeViewController(nibName: .home)
        controller?.loadView()
        interactor = HomeInteractorMock()
        
        controller?.interactor = interactor
    }
    
    override func tearDown() {
        super.tearDown()
        controller = nil
        interactor = nil
    }
    
    func test_request_camera_permission_called() {
        controller?.viewDidLoad()
        XCTAssertTrue(interactor.requestCameraPermissionCalled)
    }

    // MARK: - Actions
    func test_did_capture_button_action() {
        controller?.didTapCaptureButton(UIButton())
        XCTAssertTrue(interactor.didCaptureCalled)
    }

    func test_did_tap_open_saved_button_action() {
        controller?.didTapOpenSavedButton(UIButton())
        XCTAssertTrue(interactor.fetchColorDataCalled)
    }
    
    func test_user_saved_color() {
        controller?.userSavedColor(color: .blue)
        XCTAssertTrue(interactor.saveDataCalled)
    }
    
    func test_user_saved_color_not_saved() {
        controller?.userSavedColor(color: nil)
        XCTAssertFalse(interactor.saveDataCalled)
    }
    
    func test_deleteColor_called() {
        controller?.didDeletedItem(MPKManagedObject())
        XCTAssertTrue(interactor.removeObjectCalled)
    }
    
    func test_updatInterfaceState_show() {
        controller?.updateInterfaceState(state: .show)
        guard let captureButton = controller?.captureButton else { return XCTFail() }
        XCTAssertTrue(captureButton.alpha == 1)
    }
}
