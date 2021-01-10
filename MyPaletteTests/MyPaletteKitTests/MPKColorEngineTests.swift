//
//  MPKColorEngineTests.swift
//  MyPaletteTests
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import XCTest
import UIKit
@testable import MyPalette

class MPKColorEngineTests: XCTestCase {
    
    func test_convert_uiColorToColorSpace() {
        var converted = MPKColorEngine.uiColorToColorSpace(color: .black)
        XCTAssert(converted == "0 1")
    
        converted = MPKColorEngine.uiColorToColorSpace(color: .red)
        XCTAssert(converted == "1 0 0 1")
        
        converted = MPKColorEngine.uiColorToColorSpace(color: .white)
        XCTAssert(converted == "1 1")
    }
    
    func test_convert_colorSpaceToUIColor() {}
    
    func test_convert_UIColorToString() {
        var converted = MPKColorEngine.convertUIColorToString(using: .black)
        XCTAssert(converted == "#000000")
        
        converted = MPKColorEngine.convertUIColorToString(using: .red)
        XCTAssert(converted == "#FF0000")
        
        converted = MPKColorEngine.convertUIColorToString(using: .white)
        XCTAssert(converted == "#FFFFFF")
    }
    
    func test_getMiddlePixelColor_correct() {
        // This image contains a red #FF0000 color
        guard let image = UIImage(named: "test_image") else { return XCTFail() }
        let color = MPKColorEngine.getMiddlePixelColor(for: image)
        let r: CGFloat = 1.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 1.0
            
        XCTAssert(color.cgColor.components?[0] == r)
        XCTAssert(color.cgColor.components?[1] == g)
        XCTAssert(color.cgColor.components?[2] == b)
        XCTAssert(color.cgColor.components?[3] == a)
    }
    
    func test_getMiddlePixelColor_wrong() {
        // This image contains a red #FF0000 color
        guard let image = UIImage(named: "test_image") else { return XCTFail() }
        let color = MPKColorEngine.getMiddlePixelColor(for: image)
        let r: CGFloat = 0.0, g: CGFloat = 1.0, b: CGFloat = 0.0, a: CGFloat = 0.0
            
        XCTAssertFalse(color.cgColor.components?[0] == r)
        XCTAssertFalse(color.cgColor.components?[1] == g)
        XCTAssertTrue(color.cgColor.components?[2] == b)
        XCTAssertFalse(color.cgColor.components?[3] == a)
    }
}
