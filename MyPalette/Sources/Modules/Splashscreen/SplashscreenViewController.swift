//
//  SplashscreenViewController.swift
//  MyPalette
//
//  Created by Leonardo Santos on 11/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import UIKit
import Lottie

class SplashscreenViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var animationView: UIView!
    
    // MARK: Lazy Priperties
    private lazy var lottieAnimationView: AnimationView = {
        let view = AnimationView(name: "splash_animation")
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    // MARK: Properties
    lazy var router: SplashscreenRouterProtocol = SplashscreenRouter(controller: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationView.addSubview(lottieAnimationView)
        lottieAnimationView.frame = animationView.bounds
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.lottieAnimationView.play() { _ in
                self.router.routeToHome()
            }
        }
    }
}
