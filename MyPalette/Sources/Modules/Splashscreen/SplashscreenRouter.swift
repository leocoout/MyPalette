//
//  SplashscreenRouter.swift
//  MyPalette
//
//  Created by Leonardo Santos on 11/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

public protocol SplashscreenRouterProtocol {
    func routeToHome()
}

class SplashscreenRouter {
    
    var controller: SplashscreenViewController?
    
    init(controller: SplashscreenViewController) {
        self.controller = controller
    }
}

extension SplashscreenRouter: SplashscreenRouterProtocol {
    func routeToHome() {
        let home = HomeViewController(nibName: .home)
        home.modalPresentationStyle = .fullScreen
        home.modalTransitionStyle = .crossDissolve
        
        HomeBuilder.buildModule(using: home)
        controller?.navigationController?.present(
            home, animated: true, completion: nil
        )
    }
}
