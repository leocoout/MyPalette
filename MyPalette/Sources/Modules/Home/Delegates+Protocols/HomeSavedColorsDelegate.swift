//
//  HomeSavedColorsDelegate.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: SavedColorsDelegate {
    func didTapEmptyStateButton() {
        didTapOpenSavedButton(self)
    }
    
    func didSelectItem(with data: MPKManagedObject) {
        router.routeToDetails(using: data)
    }
    
    func didDeletedItem(_ item: MPKManagedObject) {
        interactor?.removeObject(item)
    }
}
