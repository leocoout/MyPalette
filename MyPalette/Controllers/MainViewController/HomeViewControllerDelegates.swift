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
        DispatchQueue.main.async {
            switch state {
            case .hide:
                self.hideInterface()
            case .show:
                self.showInterface()
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
                self.savedColorsButton.alpha = 0
            })
        }
    }
    
    func showInterface() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.aimView.alpha = 0.5
            self.captureButton.alpha = 1
            self.captureButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.savedColorsButton.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.captureButton.transform = .identity
            })
        }
    }
}

extension HomeViewController: SavedColorsDelegate {
    func didTapEmptyStateButton() {
        didTapOpenSavedButton(self)
    }
}
