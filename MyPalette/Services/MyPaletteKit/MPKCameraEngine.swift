//
//  MPKCameraEngine.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import AVKit
import UIKit

public protocol MPKCameraEngineDelegate: class {
    func imageDidProcessed(color: UIColor)
    func configurationCommited()
    func cameraStateUpdated(to state: MPKCameraViewState)
}

private protocol MPKCameraEngineProtocol {
    
    var delegate: MPKCameraEngineDelegate { get set }
    var captureDevice: AVCaptureDevice? { get set }
    var photoOutput: AVCapturePhotoOutput { get set }
    var previewLayer: AVCaptureVideoPreviewLayer? { get set }
    var cameraViewState: MPKCameraViewState { get set }
    var photoImageView: UIImageView { get set }
    var captureSession: AVCaptureSession { get set }
    
    init(delegate: MPKCameraEngineDelegate)
    
    /// Used to capture photo. It creates a AVCapturePhotosettings and defines preview format.
    func capture()
    
    /// It will configure the capture session, get available devices  and add photo output to the session
    /// - Parameter view: view that will be used to add photo preview in the background
    func configure(at view: UIView)
}

public class MPKCameraEngine: NSObject, MPKCameraEngineProtocol {
    
    // MARK: Protocol Properties
    var delegate: MPKCameraEngineDelegate
    var captureDevice: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput = AVCapturePhotoOutput()
    var photoImageView: UIImageView = UIImageView()
    var captureSession: AVCaptureSession = AVCaptureSession()
    
    var cameraViewState: MPKCameraViewState = .loaded {
        didSet {
            delegate.cameraStateUpdated(to: cameraViewState)
        }
    }
    
    // MARK: Private Properties
    private var view: UIView?
    private let sessionQueue = DispatchQueue(label: "session queue",
                                             attributes: [],
                                             target: nil)
    
    required init(delegate: MPKCameraEngineDelegate) {
        self.delegate = delegate
    }
    
    public func capture() {
        changeCameraViewState(to: .loading)
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
    
        if let firstAvailablePreviewPhotoPixelFormatTypes = photoSettings.__availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: firstAvailablePreviewPhotoPixelFormatTypes]
        }

        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    public func configure(at view: UIView) {
        self.view = view
        configureCamera()
    }
}

// MARK: - Private Methods
extension MPKCameraEngine {
    private func configureCamera() {
        self.sessionQueue.async { [unowned self] in
            self.configureSession()
        }
    }
    
    private func configureSession() {
        changeCameraViewState(to: .loading)
        
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .hd1920x1080
        
        let availableDevices = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
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
    
    private func setupImageView() {
        
        guard let view = view else { return }
        
        view.addSubview(photoImageView)
        photoImageView.frame = view.bounds
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.isHidden = true
    }
    
    private func setupPreviewLayer() {
        
        guard let view = view else { return }
        
        DispatchQueue.main.async { [unowned self] in
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer?.videoGravity = .resizeAspectFill
            self.previewLayer?.connection?.videoOrientation = .portrait

            guard let previewLayer = self.previewLayer else { return }
            view.layer.addSublayer(previewLayer)
            previewLayer.cornerRadius = 16
            previewLayer.frame = view.bounds

            self.captureSession.startRunning()
            changeCameraViewState(to: .loaded)
            self.delegate.configurationCommited()
        }
    }
    
    private func changeCameraViewState(to state: MPKCameraViewState) {
        cameraViewState = state
    }
}


extension MPKCameraEngine: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else { return }
        
        setupImageView()
        
        if let png = image.pngData() {
            changeCameraViewState(to: .loaded)

            let pngImage = UIImage(data: png)
            photoImageView.image = image
            
            let color = pngImage?.getPixelColor() ?? .black
            delegate.imageDidProcessed(color:color)
        }

        photoImageView.removeFromSuperview()
    }
}
