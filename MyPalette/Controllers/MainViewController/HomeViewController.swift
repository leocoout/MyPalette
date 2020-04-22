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

enum HomeContentState {
    case enabled, disabled
    
    func toggle() -> HomeContentState {
        switch self {
        case .enabled: return .disabled
        case .disabled: return .enabled
        }
    }
    
    func changeDisabledMask() -> CGFloat {
        switch self {
        case .enabled: return 0
        case .disabled: return 0.8
        }
    }
}

class HomeViewController: UIViewController {
    
 
    // MARK: Outlets
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var cameraContent: UIView!
    @IBOutlet weak var captureButton: UIView!
    @IBOutlet weak var aimView: UIView!
    @IBOutlet weak var savedColorsButton: UIButton!
    @IBOutlet weak var disabledMaskView: UIView!
    @IBOutlet weak var savedColorsView: SavedColorsView!
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    
    // MARK: Properties
    private lazy var cameraView = CameraView()
    private lazy var disabledCamera = CameraDisabledView()
    private var contentState: HomeContentState = .enabled
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        savedColorsButton.transform = savedColorsButton.transform.rotated(by: .pi)
        requestCameraPermission()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        aimView.layer.borderWidth = 1
        aimView.layer.borderColor = UIColor.white.cgColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
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

    @IBAction func didTapOpenSavedButton(_ sender: Any) {
        animateContentView()
        savedColorsView.setupWith(state: .loaded)
    }
}

// MARK: - Private methods
extension HomeViewController {
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { response in
            DispatchQueue.main.async {
                if response {
                    self.setupSavedColorsView()
                    self.setupCameraScreen()
                    self.cameraView.configureCamera()
                } else {
                    self.setupDisabledScreen()
                }
            }
        }
    }
    
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
    
    private func animateContentView() {
        contentState = contentState.toggle()
        contentState == .enabled ? showInterface() : hideInterface()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.containerBottomConstraint.constant = self.contentState == .enabled ? 0 : 200
                self.cameraView.frame.origin.y = self.contentState == .enabled ? 0 : -200
                self.disabledMaskView.alpha = self.contentState.changeDisabledMask()
                self.view.layoutIfNeeded()
            })
        }
    }
}
