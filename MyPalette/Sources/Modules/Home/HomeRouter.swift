//
//  HomeRouter.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterProtocol {
    func routeToDetails(using data: MPKManagedObject)
}

class HomeRouter {
    
    var controller: HomeViewController
    
    init(controller: HomeViewController) {
        self.controller = controller
    }
    
    private func pushController(_ controller: UIViewController) {
        controller.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func presentController(_ controller: UIViewController) {
        controller.present(controller, animated: true, completion: nil)
    }
}

// MARK: - HomeRouterProtocol Method Implementation
extension HomeRouter: HomeRouterProtocol {
    func routeToDetails(using data: MPKManagedObject) {
        let detailsController = buildDetails(data: data)
        let detailsFlow = MyPaletteNavigation.createFlow(using: detailsController, title: "Detalhes da cor")
        controller.present(detailsFlow, animated: true, completion: nil)
    }
}

// MARK: - Private Methods
extension HomeRouter {
    private func buildDetails(data: MPKManagedObject) -> DetailsViewController {
        let details = DetailsViewController(nibName: .details)
        DetailsBuilder.buildModule(using: details, using: data)
        return details
    }
}
