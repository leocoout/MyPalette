//
//  MPKColorEngine.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
    
public class MPKColorEngine {
    
    /// Converts UIColor to ColorSpace String
    /// - Parameter color: color used for convertion
    /// - Returns: returns the string of the color, for example:
    static func uiColorToColorSpace(color: UIColor) -> String {
        let strColor = color.description
        let components = strColor.components(separatedBy: " ")
        var str = String()
        
        for component in 1...components.count - 1{
            str += components[component] + " "
        }
        
        return String(str.dropLast())
    }
    
    /// Converts colorSpace, like    , to UIColor
    /// - Parameter value: color space string
    /// - Returns: the UIColor object associated to the value
    static func colorSpaceToUIColor(value: MPKColorSpace) -> UIColor {
        
        if let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) {
            let strComponents = value.components(separatedBy: " ")
            var components = [CGFloat]()
            
            strComponents.forEach {
                components.append(CGFloat(($0 as NSString).floatValue))
            }
            return UIColor(
                cgColor: CGColor(
                    colorSpace: colorSpace,
                    components: components) ??
                    UIColor.myPaletteGray.cgColor
            )
        }
        
        return .myPaletteGray
    }
}
