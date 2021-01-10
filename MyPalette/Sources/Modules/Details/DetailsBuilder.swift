//
//  DetailsBuilder.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

class DetailsBuilder {
    
    typealias DetailsViewControllerProtocols = DetailsViewControllerProtocol & DetailsViewControllerDataStore
    
    class func buildModule(using view: DetailsViewControllerProtocols, using data: MPKManagedObject) {
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter()
    
        view.interactor = interactor
        view.presenter = presenter
        view.colorData = data
        presenter.view = view
        interactor.presenter = presenter
    }
}
