//
//  HomeViewModel.swift
//  MyPalette
//
//  Created by Leonardo Santos on 09/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// MARK: - HomeViewModelProtocol Methods
public protocol HomeViewModelProtocol {
    func setContentState(to state: HomeContentState)
    func getContentState() -> HomeContentState
    func getContentStateMask() -> CGFloat
    func toggleContentState()
    func setSavedColorsViewState(to state: SavedColorsViewState)
    func setSavedColorsViewState(to state: Bool)
    func getSavedColorsViewState() -> SavedColorsViewState
    func getSavedColorsViewIsOpen() -> Bool
}

// MARK: - SavedColorsViewState
public enum SavedColorsViewState {
    case open, closed, empty, loaded, needSetup, dontNeedSetup
}

// MARK: - HomeContentState
public enum HomeContentState {
    case enabled, disabled
    
    mutating func toggle() {
        switch self {
        case .enabled: self = .disabled
        case .disabled: self = .enabled
        }
    }
    
    func changeDisabledMask() -> CGFloat {
        switch self {
        case .enabled: return 0
        case .disabled: return 0.8
        }
    }
}

// MARK: - HomeViewModelProtocol Class and protocol conformance
public class HomeViewModel: HomeViewModelProtocol {
    
    public var contentState: HomeContentState = .enabled
    public var savedColorsViewNeedSetup: Bool = false
    public var savedColorsViewState: SavedColorsViewState = .closed
    
    public func setContentState(to state: HomeContentState) {
        contentState = state
    }
    
    public func getContentState() -> HomeContentState {
        return contentState
    }
    
    public func getContentStateMask() -> CGFloat {
        return contentState.changeDisabledMask()
    }
    
    public func toggleContentState() {
        contentState.toggle()
    }
    
    public func setSavedColorsViewState(to state: SavedColorsViewState) {
        savedColorsViewState = state
    }
    
    public func setSavedColorsViewState(to state: Bool) {
        savedColorsViewState = state ? .open : .closed
    }
    
    public func getSavedColorsViewIsOpen() -> Bool {
        return savedColorsViewState == .open
    }
    
    public func getSavedColorsViewState() -> SavedColorsViewState {
        return savedColorsViewState
    }
}

