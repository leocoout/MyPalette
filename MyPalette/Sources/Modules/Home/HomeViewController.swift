//
//  HomeViewController.swift
//  MyPalette
//
//  Created by Leonardo Santos on 24/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewControllerProtocol: class {
    var interactor: HomeInteractorProtocol? { get set }
    var presenter: HomePresenterProtocol? { get set }

    func handleCameraPermissionAuthorized()
    func handleCameraPermissionUnauthorized()
    func handleDataRecovered(response: [MPKManagedObject])
    func handleCaptureAction()
}

class HomeViewController: UIViewController, HomeViewControllerProtocol {
    
    // MARK: Outlets
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var cameraContent: UIView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var aimView: UIView!
    @IBOutlet weak var savedColorsButton: UIButton!
    @IBOutlet weak var disabledMaskView: UIView!
    @IBOutlet weak var savedColorsView: SavedColorsView!
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    
    // MARK: Protocol Properties
    lazy var viewModel: HomeViewModelProtocol = HomeViewModel()
    var interactor: HomeInteractorProtocol?
    var presenter: HomePresenterProtocol?
    
    // MARK: Properties
    lazy var cameraView = CameraView()
    lazy var disabledCamera = CameraDisabledView()
    lazy var router: HomeRouterProtocol = HomeRouter(controller: self)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        savedColorsButton.transform = savedColorsButton.transform.rotated(by: .pi)
        interactor?.requestCameraPermission()
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
    
    func animateContentView() {
        viewModel.setSavedColorsViewState(to: viewModel.getContentState() == .disabled)
        viewModel.toggleContentState()
        viewModel.getContentState() == .enabled ? showInterface() : hideInterface()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.cameraContent.backgroundColor = self.viewModel.getContentState() == .disabled ? .white : .black
                self.containerBottomConstraint.constant = self.viewModel.getContentState() == .enabled ? 0 : 200
                self.cameraView.frame.origin.y = self.viewModel.getContentState() == .enabled ? 0 : -200
                self.disabledMaskView.alpha = self.viewModel.getContentStateMask()
                self.view.layoutIfNeeded()
            })
        }
    }
}

// MARK: - Actions
extension HomeViewController {

    @IBAction func didTapCaptureButton(_ sender: UIButton) {
        interactor?.didCapture()
    }

    @IBAction func didTapOpenSavedButton(_ sender: Any) {
        animateContentView()
        
        if !viewModel.getSavedColorsViewIsOpen() {
            interactor?.fetchColorData()
        }
    }
}
