//
//  CameraView.swift
//  MyPalette
//
//  Created by Leonardo Santos on 12/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class CameraView: UIView {
    
    // MARK: Properties
    private let captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private lazy var disabledView = CameraDisabledView()

    func checkCameraAuthorization() {
        requestCameraPermission()
    }
}

// MARK: - Private methods
extension CameraView {
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] response in
            DispatchQueue.main.async {
                response ? self?.setupCamera() : self?.setupGetAccessView()
            }
        }
    }
    
    private func setupCamera() {
        captureSession.sessionPreset = .photo
        
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back).devices.first
        captureDevice = availableDevices
        beginSession()
    }
    
    private func setupGetAccessView() {
        addSubview(disabledView)
        disabledView.frame = bounds
    }
    
    
    private func beginSession() {
        guard let captureDevice = captureDevice else { return }
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.connection?.videoOrientation = .portrait
        
        guard let previewLayer = previewLayer else { return }
        layer.addSublayer(previewLayer)
        previewLayer.cornerRadius = 16
        previewLayer.frame = bounds
        
        captureSession.startRunning()
    }

}

