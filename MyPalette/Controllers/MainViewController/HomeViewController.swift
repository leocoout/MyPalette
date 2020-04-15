//
//  HomeViewController.swift
//  MyPalette
//
//  Created by Leonardo Santos on 24/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var captureButton: UIView!
    @IBOutlet weak var aimView: UIView!
    
    // MARK: Properties
    private lazy var cameraView = CameraView()
    private lazy var disabledCamera = CameraDisabledView()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        aimView.layer.borderWidth = 1
        aimView.layer.borderColor = UIColor.white.cgColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        requestCameraPermission()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - Actions
extension HomeViewController {
    @IBAction func didTapCaptureButton(_ gesture: UITapGestureRecognizer) {
        cameraView.didCapture()
    }
}

// MARK: - Private methods
extension HomeViewController {
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { response in
            DispatchQueue.main.async {
                if response {
                    self.setupCameraScreen()
                    self.cameraView.configureCamera()
                } else {
                    self.setupDisabledScreen()
                }
            }
        }
    }
    
    private func setupCameraScreen() {
        content.addSubview(cameraView)
        cameraView.frame = content.bounds
        cameraView.delegate = self
    }
    
    private func setupDisabledScreen() {
        view.addSubview(disabledCamera)
        disabledCamera.frame = view.bounds
        captureButton.isHidden = true
    }
    
}
