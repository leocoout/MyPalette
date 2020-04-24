//
//  MyPaletteColorAPI.swift
//  MyPalette
//
//  Created by Leonardo Santos on 23/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class MyPaletteColorAPI {
    
    static func uiColorToColorSpace(color: UIColor) -> String {
        let strColor = color.description
        let components = strColor.components(separatedBy: " ")
        var str = String()
        
        for component in 1...components.count - 1{
            str += components[component] + " "
        }
        
        return String(str.dropLast())
    }
    
    static func colorSpaceToUIColor(value: String) -> UIColor {
    
        if let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) {
            let strComponents = value.components(separatedBy: " ")
            var components = [CGFloat]()
            
            strComponents.forEach {
                 components.append(CGFloat(($0 as NSString).floatValue))
            }
                    
            return UIColor(cgColor: CGColor(colorSpace: colorSpace,
                                            components: components) ?? UIColor.myPalleteGray.cgColor)
        }
        
        return .myPalleteGray
    }
}


