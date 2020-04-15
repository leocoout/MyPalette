//
//  CameraViewDelegates.swift
//  MyPalette
//
//  Created by Leonardo Santos on 15/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation

extension CameraView: ColorAlertDelegate {
    func alertDidClose() {
        self.delegate?.updateInterfaceState(state: .show)
    }
}
