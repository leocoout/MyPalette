//
//  CameraView.swift
//  MyPalette
//
//  Created by Leonardo Santos on 12/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol CameraViewDelegate: class {
    func updateInterfaceState(state: MPKCameraInterfaceState)
    func userSavedColor(color: UIColor?)
}

class CameraView: UIView {
    
    // MARK: Properties
    internal lazy var alert = ColorAlert()
    private lazy var disabledView = CameraDisabledView()
    private lazy var cameraEngine = MPKCameraEngine(delegate: self)
    private var sessionStatus: MPKCameraAuthorizationStatus = .unauthorized

    weak var delegate: CameraViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAlertLayout()
    }
}

// MARK: - Public methods
extension CameraView {
    func configureCamera() {
        cameraEngine.configure(at: self)
    }
    
    public func didCapture() {
        delegate?.updateInterfaceState(state: .hide)
        cameraEngine.capture()
    }
}

// MARK: - Private methods
extension CameraView {

    private func setupGetAccessView() {
        addSubview(disabledView)
        disabledView.frame = bounds
    }
    
    private func setupAlertLayout() {
        addSubview(alert)
        alert.frame = bounds
        alert.delegate = self
    }
    
    private func removeAlert() {
        alert.removeFromSuperview()
    }
}

extension CameraView: MPKCameraEngineDelegate {
    func imageDidProcessed(color: UIColor) {
        alert.colorPicked = color
        alert.showAlert()
    }
    
    func cameraStateUpdated(to state: MPKCameraViewState) {
        DispatchQueue.main.async {
            switch state {
            case .loading:
                LoadingView.shared.startLoadingAt(self)
            case .loaded:
                LoadingView.shared.removeFromView(self)
            }
        }
    }
    
    func configurationCommited() {
        self.delegate?.updateInterfaceState(state: .show)
    }
}
