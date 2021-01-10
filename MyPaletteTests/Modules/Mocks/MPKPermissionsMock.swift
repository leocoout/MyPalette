//
//  MPKPermissionsMock.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class MPKPermissionsMock: MPKPermissions {
    
    // MARK: Properties
    var requestCameraPermissionResponse: MPKPermissionResponse = false
    
    override func requestCameraPermission(completion: @escaping (MPKPermissionResponse) -> (Void)) {
        completion(requestCameraPermissionResponse)
    }
}
