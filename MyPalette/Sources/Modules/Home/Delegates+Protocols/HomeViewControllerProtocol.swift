//
//  HomeViewControllerProtocol.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - HomeViewControllerProtocol Methods Conformance
extension HomeViewController {
    
    func handleCameraPermissionAuthorized() {
        self.setupSavedColorsView()
        self.setupCameraScreen()
        self.cameraView.configureCamera()
    }
    
    func handleCameraPermissionUnauthorized() {
        self.setupDisabledScreen()
        self.updateInterfaceState(state: .hide)
    }
    
    func handleDataRecovered(response: [MPKManagedObject]) {
        self.savedColorsView.itens = response
        self.savedColorsView.setupWith(state: response.isEmpty ? .empty : .loaded)
        self.viewModel.setSavedColorsViewState(to: response.isEmpty ? .needSetup : .dontNeedSetup)
    }
    
    func handleCaptureAction() {
        cameraView.didCapture()
    }
}

// MARK: - Private Methods to HomeViewControllerProtocol
extension HomeViewController {
    private func setupCameraScreen() {
        cameraContent.addSubview(cameraView)
        cameraView.frame = cameraContent.bounds
        cameraView.delegate = self
    }
    
    private func setupDisabledScreen() {
        view.addSubview(disabledCamera)
        disabledCamera.frame = view.bounds
        captureButton.isHidden = true
    }
    
    private func setupSavedColorsView() {
        savedColorsView.delegate = self
    }
}
