//
//  HomeBuilder.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

class HomeBuilder {
    class func buildModule(using view: HomeViewControllerProtocol) {
        let interactor = HomeInteractor(repository: HomeRepository())
        let presenter = HomePresenter()
    
        view.interactor = interactor
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
    }
}

