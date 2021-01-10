//
//  DetailsViewControllerMock.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class DetailsViewControllerMock: DetailsViewControllerProtocol, DetailsViewControllerDataStore {
    var interactor: DetailsInteractorProtocol?
    var presenter: DetailsPresenterProtocol?
    
    var data: MPKManagedObject?
}
