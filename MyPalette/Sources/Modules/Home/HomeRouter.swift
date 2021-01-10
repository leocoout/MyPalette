//
//  HomeRouter.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

protocol HomeRouterProtocol {
    func routeToDetails(using data: MPKManagedObject)
}

class HomeRouter {
    
    var controller: HomeViewController
    
    init(controller: HomeViewController) {
        self.controller = controller
    }
}

// MARK: - HomeRouterProtocol Method Implementation
extension HomeRouter: HomeRouterProtocol {
    func routeToDetails(using data: MPKManagedObject) {
        // route to details
    }
}
