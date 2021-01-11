//
//  HomeRepositoryMock.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class HomeRepositoryMock: HomeRepositoryProtocol {
    
    // MARK: Properties
    var saveDataCalled = false
    
    func saveData(model: ColorModel) {
        saveDataCalled  = true
    }

    func recoverdata(completion: @escaping ([MPKManagedObject]) -> ()) {
        completion([])
    }
    
    func deleteObject(_ object: MPKManagedObject, completion: () -> Void) {
        completion()
    }
}
