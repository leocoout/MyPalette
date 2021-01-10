//
//  DetailsViewControllerTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class DetailsViewControllerTests: XCTestCase {
    
    // MARK: Sut
    var controller: DetailsViewController?
    var interactor: DetailsInteractorMock!
    
    override func setUp() {
        super.setUp()
        controller = DetailsViewController(nibName: .details)
        controller?.loadView()
        interactor = DetailsInteractorMock()
        
        controller?.interactor = interactor
    }
    
    override func tearDown() {
        super.tearDown()
        controller = nil
        interactor = nil
    }
}
