//
//  MPKModel.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import CoreData

public typealias MPKPermissionResponse = Bool
public typealias MPKManagedObject = NSManagedObject
public typealias MPKColorSpace = String

public enum MPKCameraAuthorizationStatus {
    case authorized, unauthorized
}

public enum MPKCameraInterfaceState {
    case show, hide
}

public enum MPKCameraViewState {
    case loading, loaded
    
    func updateInterface() -> MPKCameraInterfaceState {
        switch self {
        case .loaded: return .show
        case .loading: return .hide
        }
    }
}

public enum MPKManagedObjectKeys: String {
    case colorPicked
}
