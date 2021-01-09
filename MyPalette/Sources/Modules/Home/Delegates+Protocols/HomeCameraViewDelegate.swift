//
//  HomeCameraViewDelegate.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: CameraViewDelegate {
    
    func userSavedColor(color: UIColor?) {
        
        guard let modelColor = color else { return }
        
        let model = ColorModel(color: modelColor)
        HomeRepository.saveData(model: model)
    }

    func updateInterfaceState(state: CameraInterfaceState) {
        DispatchQueue.main.async {
            switch state {
            case .hide:
                self.hideInterface()
                self.hideSavedColorsButton()
            case .show:
                self.showInterface()
                self.showSavedColorsButton()
            }
        }
    
        captureButton.isUserInteractionEnabled = state == .show
    }
    
    func hideInterface() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.captureButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.captureButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.captureButton.alpha = 0
                self.aimView.alpha = 0
            })
        }
    }
    
    func showInterface() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.aimView.alpha = 0.5
            self.captureButton.alpha = 1
            self.captureButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.captureButton.transform = .identity
            })
        }
    }
    
    private func hideSavedColorsButton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.savedColorsButton.alpha = 0
        })
    }
    
    private func showSavedColorsButton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.savedColorsButton.alpha = 1
        })
    }
}
