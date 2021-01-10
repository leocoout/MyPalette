//
//  HomeBaseDataTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
@testable import MyPalette

class HomeBaseDataTests: XCTestCase {
    
    // MARK: Sut
    var baseData: HomeViewControllerBaseData?
    private var testColor: UIColor = .black
    
    override func setUp() {
        super.setUp()
        let colorModel = ColorModel(color: testColor)
        baseData = HomeViewControllerBaseData(model: colorModel)
    }
    
    override func tearDown() {
        super.tearDown()
        baseData = nil
    }

    func test_entity_type_color() {
        XCTAssertTrue(baseData?.entity == .color)
    }
    
    func test_color_is_the_same_as_modelColor() {
        XCTAssertTrue(baseData?.color == testColor)
    }
    
    func test_data_colorPicked_key() {
        let data = baseData?.data
        let color = MPKColorEngine.uiColorToColorSpace(color: testColor)
        XCTAssertTrue(data?["colorPicked"] as? String == color)
    }
}
