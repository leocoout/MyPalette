//
//  LoadingView.swift
//  MyPalette
//
//  Created by Leonardo Santos on 14/04/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    static let shared = LoadingView()
    
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
    
        return view
    }()
    
    lazy var indicator = UIActivityIndicatorView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func startLoadingAt(_ at: UIView) {
        at.addSubview(self)
        self.frame = at.bounds
        
        setupViews()
        
        UIView.animate(withDuration: 0.3) {
            self.background.alpha = 0.8
        }
    }
    
    func removeFromView(_ view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            self.background.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    private func setupViews() {
        addSubview(background)
        background.frame = bounds
        
        addSubview(indicator)
        indicator.frame = bounds
        indicator.startAnimating()
    }
}
