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
    @IBOutlet weak var cameraContent: UIView!
    @IBOutlet weak var captureButton: UIButton!
    
    // MARK: Properties
    private var cameraView = CameraView()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCameraLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        cameraView.checkCameraAuthorization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraView.stopSessionRunning()
    }
}

// MARK: - Actions
extension HomeViewController {
    @IBAction func didTapCaptureButton(_ sender: Any) {
        cameraView.didCapture()
    }
}

// MARK: - Private methods
extension HomeViewController {
    private func setupCameraLayout() {
        cameraContent.addSubview(cameraView)
        cameraView.frame = cameraContent.bounds
    }
}
