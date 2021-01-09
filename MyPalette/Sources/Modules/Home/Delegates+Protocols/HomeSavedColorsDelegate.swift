//
//  HomeSavedColorsDelegate.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation

extension HomeViewController: SavedColorsDelegate {
    func didTapEmptyStateButton() {
        didTapOpenSavedButton(self)
    }
}
