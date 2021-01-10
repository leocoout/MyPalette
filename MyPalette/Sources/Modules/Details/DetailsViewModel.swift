//
//  DetailsViewModel.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsViewModelProtocol {
    func setData(_ data: MPKManagedObject?)
    func getColorAsHexadecimalString() -> String
    func getColorAsUIColor() -> UIColor
    func numberOfSections() -> Int
    func numberOfRows(at section: Int) -> Int
}

enum DetailsTableViewSections: Int {
    case header
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    private var data: MPKManagedObject?
    private var colorPicked: String? {
        return self.data?.getColorPicked()
    }
    
    func setData(_ data: MPKManagedObject?) {
        self.data = data
    }
    
    /// Return color as String
    /// - Returns: String as #000000
    func getColorAsHexadecimalString() -> String {
        MPKColorEngine.convertUIColorToString(using: getColorAsUIColor())
    }
    
    /// Return the UIColor Object
    /// - Returns: UIColor object
    func getColorAsUIColor() -> UIColor {
        guard let colorPicked = colorPicked else { return .black }
        return MPKColorEngine.colorSpaceToUIColor(value: colorPicked)
    }
    
    struct Section {
        static let sections = ["header"]
    }
    
    func numberOfSections() -> Int {
        return Section.sections.count
    }
    
    func numberOfRows(at section: Int) -> Int {
        switch DetailsTableViewSections(rawValue: section) {
        case .header: return 1
        default: return 0
        }
    }
}
