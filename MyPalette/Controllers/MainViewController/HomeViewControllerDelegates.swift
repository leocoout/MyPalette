//
//  HomeViewControllerDelegates.swift
//  MyPalette
//
//  Created by Leonardo Santos on 14/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: CameraViewDelegate {
    
    func updateInterfaceState(state: CameraInterfaceState) {
        switch state {
        case .hide:
            hideInterface()
        case .show:
            showInterface()
        }
    }
    
    private func hideInterface() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.captureButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    self.captureButton.transform = CGAffineTransform(scaleX: 0, y: 0)
                }) { _ in
                    self.captureButton.alpha = 0
                }
            }
        }
    }
    
    private func showInterface() {
        UIView.animate(withDuration: 0.5) {
            self.captureButton.alpha = 1
        }
    }
}
