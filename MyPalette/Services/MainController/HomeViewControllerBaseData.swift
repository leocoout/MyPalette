//
//  MainControllerBaseData.swift
//  MyPalette
//
//  Created by Leonardo Santos on 22/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class HomeViewControllerBaseData: BaseData {
    
    var color: UIColor
    
    init(model: ColorModel) {
        self.color = model.color
    }
    
    var entity: MyPalleteServiceAPIType = .color
    
    var data: [String : Any?] {
        return ["colorPicked": MyPaletteColorAPI.uiColorToColorSpace(color: self.color)]
    }
}
