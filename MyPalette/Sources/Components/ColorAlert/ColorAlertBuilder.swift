//
//  ColorAlertBuilder.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

/// Object with all properties to configure ColorAlert
struct ColorAlertConfigurator {
    var color: UIColor = .black
    var closeAction: (() -> Void)? = nil
    var saveColorAction: ((UIColor?) -> Void)? = nil
}

/// Builder class for ColorCard Component
class ColorAlertBuilder {
    
    private var config = ColorAlertConfigurator()
    
    /// Build Color Alert with the picked color
    /// - Parameter color: picked color from captured image
    func with(color: UIColor) -> ColorAlertBuilder {
        config.color = color
        return self
    }
    
    /// Use this method to perform an action when alert closes
    func close(action: @escaping () -> Void) -> ColorAlertBuilder {
        config.closeAction = action
        return self
    }
    
    /// Use this method to perform an action when user saves the color
    /// - Parameter action: it will escape a UIColor object
    func save(action: @escaping (UIColor?) -> Void) -> ColorAlertBuilder {
        config.saveColorAction = action
        return self
    }
    
    func build(with frame: CGRect) -> ColorAlert {
        let view = ColorAlert(frame: frame)
        view.config = config
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            view.showAlert()
        }

        return view
    }
}
