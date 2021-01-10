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
    /// - Returns: returns the string of the color, for example: `0.862745 0.690196 0.262745 1`
    static func uiColorToColorSpace(color: UIColor) -> String {
        let strColor = color.description
        let components = strColor.components(separatedBy: " ")
        var str = String()
        
        for component in 1...components.count - 1{
            str += components[component] + " "
        }
        
        return String(str.dropLast())
    }
    
    /// Converts colorSpace like  `0.862745 0.690196 0.262745 1` to UIColor
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
    
    /// Converts the hexadecimal value of a UIColor object to a string starting with #
    /// - Returns: the string value
    static func convertUIColorToString(using color: UIColor) -> String {
        guard let colorRef = color.cgColor.components else { return "Não foi possível detectar a cor" }
        
        let r:CGFloat = colorRef[0]
        let g:CGFloat = colorRef[1]
        let b:CGFloat = colorRef[2]
        
        return String(format: "#%02lX%02lX%02lX",
                      lroundf(Float(r * 255)),
                      lroundf(Float(g * 255)),
                      lroundf(Float(b * 255)))
    }
    
    /// Gets the color of the pixel localized in the center of the image
    /// - Parameter image: the image that will be used to get the pixel color
    /// - Returns: the UIColor of the middle mixel
    static func getMiddlePixelColor(for image: UIImage) -> UIColor {

        let pixelData = image.cgImage?.dataProvider?.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pos = image.size
        let pixelInfo: Int = ((Int(pos.width) * Int(pos.height / 2)) + Int(pos.width / 2)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

