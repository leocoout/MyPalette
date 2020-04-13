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
    
    // MARK: Properties
    var cameraView = CameraView()
    
    // MARK: View Lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCameraLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraView.checkCameraAuthorization()
    }
}

// MARK: - Private methods
extension HomeViewController {
    private func setupCameraLayout() {
        cameraContent.addSubview(cameraView)
        cameraView.frame = cameraContent.bounds
    }
}
