//
//  CameraViewDelegates.swift
//  MyPalette
//
//  Created by Leonardo Santos on 15/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension CameraView: ColorAlertDelegate {
    func alertDidClose() {
        self.delegate?.updateInterfaceState(state: .show)
    }
    
    func colorDidSave(color: UIColor?) {
        delegate?.userSavedColor(color: color)
    }
}
