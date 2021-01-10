//
//  DetailsPresenterTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class DetailsPresenterTests: XCTestCase {
    
    // MARK: Sut
    var presenter: DetailsPresenter?
    var view: DetailsViewControllerMock!
    
    override func setUp() {
        super.setUp()
        presenter = DetailsPresenter()
        view = DetailsViewControllerMock()
        
        presenter?.view = view
    }
    
    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
    }
}
