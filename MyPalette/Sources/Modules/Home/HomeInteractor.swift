//
//  HomeInteractor.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

protocol HomeInteractorProtocol {}

class HomeInteractor {
    
    // MARK: Properties
    var presenter: HomePresenterProtocol?
    var repository: HomeRepositoryProtocol?
    
    init(repository: HomeRepositoryProtocol?) {
        self.repository = repository
    }
}

extension HomeInteractor: HomeInteractorProtocol {}
