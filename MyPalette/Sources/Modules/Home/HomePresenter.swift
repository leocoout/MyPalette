//
//  HomePresenter.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

protocol HomePresenterProtocol {}

class HomePresenter {
    
    // MARK: Properties
    weak var view: HomeViewControllerProtocol?
}

extension HomePresenter: HomePresenterProtocol {
    
}
