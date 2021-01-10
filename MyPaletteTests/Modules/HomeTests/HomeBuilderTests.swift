//
//  HomeBuilderTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class HomeBuilderTests: XCTestCase {
    
    // MARK: Sut
    var controller: HomeViewControllerMock!
    
    override func setUp() {
        super.setUp()
        controller = HomeViewControllerMock()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_build_module() {
        HomeBuilder.buildModule(using: controller)
        XCTAssertNotNil(controller.interactor)
        XCTAssertNotNil(controller.presenter)
    }
}
