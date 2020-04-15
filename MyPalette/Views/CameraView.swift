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

enum CameraAuthorizationStatus {
    case authorized, unauthorized
}

enum CameraViewState {
    case loading, loaded
}

protocol CameraViewDelegate: class {
    func updateCameraState(state: CameraViewState)
}

class CameraView: UIView {
    
    // MARK: Properties
    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    private lazy var photoImageView = UIImageView()
    private lazy var alert = ColorAlert()
    private lazy var disabledView = CameraDisabledView()

    private var captureDevice: AVCaptureDevice?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var videoDeviceInput: AVCaptureDeviceInput?
    private var sessionStatus: CameraAuthorizationStatus = .unauthorized
    private let sessionQueue = DispatchQueue(label: "session queue",
                                             attributes: [],
                                             target: nil)
    
    weak var delegate: CameraViewDelegate?
    private var cameraViewState: CameraViewState = .loaded {
        didSet {
            updateCameraState()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImageView()
        setupAlertLayout()
    
    }

}

// MARK: - Public methods
extension CameraView {
    public func checkCameraAuthorization() {
        requestCameraPermission()
    }

    public func stopSessionRunning() {
        sessionQueue.async { [unowned self] in
            if self.sessionStatus == .authorized {
                self.captureSession.stopRunning()
            }
        }
    }
    
    public func didCapture() {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true

        if let firstAvailablePreviewPhotoPixelFormatTypes = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: firstAvailablePreviewPhotoPixelFormatTypes]
        }
        
        cameraViewState = .loading
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
}

// MARK: - Private methods
extension CameraView {
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { response in
            if response {
                self.sessionQueue.async { [unowned self] in
                    self.sessionStatus = .authorized
                    self.configureSession()
                }
            } else {
                self.sessionStatus = .unauthorized
                self.setupGetAccessView()
            }
        }
    }
    
    private func setupGetAccessView() {
        addSubview(disabledView)
        disabledView.frame = bounds
    }
    
    private func setupAlertLayout() {
        addSubview(alert)
        alert.frame = bounds
    }
    
    private func setupImageView() {
        addSubview(photoImageView)
        photoImageView.frame = bounds
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.isHidden = true
    }
    
    private func configureSession() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .hd1920x1080
        
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back).devices.first
        
        captureDevice = availableDevices
        
        guard let captureDevice = captureDevice else { return }
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
            captureSession.commitConfiguration()
            return
        }
        
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
            
            photoOutput.isHighResolutionCaptureEnabled = true
            photoOutput.isLivePhotoCaptureEnabled = photoOutput.isLivePhotoCaptureSupported
        } else {
            print("Erro ao cadastrar a foto na sessão")
            captureSession.commitConfiguration()
            return
        }
              
        captureSession.commitConfiguration()
        
        setupPreviewLayer()
    }
    
    private func setupPreviewLayer() {
        DispatchQueue.main.async { [unowned self] in
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer?.videoGravity = .resizeAspectFill
            self.previewLayer?.connection?.videoOrientation = .portrait
        
            guard let previewLayer = self.previewLayer else { return }
            self.layer.addSublayer(previewLayer)
            previewLayer.cornerRadius = 16
            previewLayer.frame = self.bounds
        
            self.captureSession.startRunning()
        }
    }
    
    private func updateCameraState() {
        switch cameraViewState {
        case .loading:
            LoadingView.shared.startLoadingAt(self)
        case .loaded:
            LoadingView.shared.removeFromView(self)
        }
        
        delegate?.updateCameraState(state: cameraViewState)
    }
}

extension CameraView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        setupImageView()

        guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else { return }
        if let png = image.pngData() {
            cameraViewState = .loaded
            
            let pngImage = UIImage(data: png)
            photoImageView.image = image
            alert.colorPicked = pngImage?.getPixelColor() ?? .black
            alert.showAlert()
        }
    }
}
