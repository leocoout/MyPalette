//
//  HomeInteractorMock.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
import UIKit
@testable import MyPalette

class HomeInteractorMock: HomeInteractorProtocol {
    
    // MARK: Properties
    var requestCameraPermissionCalled = false
    var fetchColorDataCalled = false
    var removeObjectCalled = false
    var didCaptureCalled = false
    var saveDataCalled = false
    
    func requestCameraPermission() {
        requestCameraPermissionCalled = true
    }
    
    func fetchColorData() {
        fetchColorDataCalled = true
    }
    
    func removeObject(_ object: MPKManagedObject) {
        removeObjectCalled = true
    }
    
    func saveData(color: UIColor?) {
        saveDataCalled = color != nil 
    }
    
    func didCapture() {
        didCaptureCalled = true
    }
}
