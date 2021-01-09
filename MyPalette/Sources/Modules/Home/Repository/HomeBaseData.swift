//
//  HomeBaseData.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class HomeViewControllerBaseData: MPKBaseData {
    
    var color: UIColor
    
    init(model: ColorModel) {
        self.color = model.color
    }
     
    var entity: MPKLocalServiceType = .color
    
    var data: [String : Any?] {
        return ["colorPicked": MPKColorEngine.uiColorToColorSpace(color: self.color)]
    }
}
