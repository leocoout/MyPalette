//
//  HomePresenterMock.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class HomePresenterMock: HomePresenterProtocol {
    
    // MARK: Properties
    var presentRequestAuthorizedCalled = false
    var presentRequestUnauthorizedCalled = false
    var presentDataRecoveredCalled = false
    var presentCaptureCalled = false
    
    func presentRequestAuthorized() {
        presentRequestAuthorizedCalled = true
    }
    
    func presentRequestUnauthorized() {
        presentRequestUnauthorizedCalled = true
    }
    
    func presentDataRecovered(response: [MPKManagedObject]) {
        presentDataRecoveredCalled = true
    }
    
    func presentCapture() {
        presentCaptureCalled = true
    }
}
