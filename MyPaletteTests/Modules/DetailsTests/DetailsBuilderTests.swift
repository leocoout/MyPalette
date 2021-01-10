//
//  DetailsBuilderTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class DetailsBuilderTests: XCTestCase {
    
    // MARK: Sut
    var controller: DetailsViewControllerMock!
    
    override func setUp() {
        super.setUp()
        controller = DetailsViewControllerMock()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_build_module() {
        DetailsBuilder.buildModule(
            using: controller,
            using: MPKManagedObject()
        )
        
        XCTAssertNotNil(controller.interactor)
        XCTAssertNotNil(controller.data)
        XCTAssertNotNil(controller.presenter)
    }
}
