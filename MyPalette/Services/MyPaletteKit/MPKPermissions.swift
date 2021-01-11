//
//  MPKPermissions.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import AVFoundation

public class MPKPermissions {
    
    /// Request camera permission for usage to detect colors
    /// - Returns: MPKPermissionResponse same as Bool
    public func requestCameraPermission(completion: @escaping (MPKPermissionResponse) -> (Void)) {
        AVCaptureDevice.requestAccess(for: .video) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}
    
   
