//
//  DetailsViewController.swift
//  MyPalette
//
//  Created by Leonardo Santos on 10/01/21.
//  Copyright © 2021 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsViewControllerProtocol: class {
    var interactor: DetailsInteractorProtocol? { get set }
    var presenter: DetailsPresenterProtocol? { get set }
}

protocol DetailsViewControllerDataStore: class {
    var colorData: MPKManagedObject? { get set }
}

class DetailsViewController: UIViewController, DetailsViewControllerProtocol, DetailsViewControllerDataStore {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Protocol Properties
    var interactor: DetailsInteractorProtocol?
    var presenter: DetailsPresenterProtocol?
    
    // MARK: DataStore
    var colorData: MPKManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let backgroundColor = colorData?.getColorPicked() else { return }
        view.backgroundColor = MPKColorEngine.colorSpaceToUIColor(value: backgroundColor)
        
        print()
    }
  
}
