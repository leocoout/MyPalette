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
    func updateCameraState(state: CameraViewState) {
        switch state {
        case .loading:
            hideInterface()
        case .loaded: break
        }
    }
    
    private func hideInterface() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.captureButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }
       
    }
}
