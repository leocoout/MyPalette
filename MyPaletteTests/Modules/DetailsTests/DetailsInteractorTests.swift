//
//  DetailsInteractorTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class DetailsInteractorTests: XCTestCase {
    
    // MARK: Sut
    var interactor: DetailsInteractor?
    var presenter: DetailsPresenterMock!
    
    override func setUp() {
        super.setUp()
        interactor = DetailsInteractor()
        presenter = DetailsPresenterMock()
        
        interactor?.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
    }
    
}
