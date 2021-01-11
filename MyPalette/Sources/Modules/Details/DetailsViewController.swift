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
    var data: MPKManagedObject? { get set }
}

class DetailsViewController: UIViewController, DetailsViewControllerProtocol, DetailsViewControllerDataStore {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Protocol Properties
    var interactor: DetailsInteractorProtocol?
    var presenter: DetailsPresenterProtocol?
    
    // MARK: DataStore
    var data: MPKManagedObject?
    
    // MARK: Properties
    lazy var viewModel: DetailsViewModelProtocol = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setData(data)
        setupTableView()
    }
}

// MARK: - Private Methods
extension DetailsViewController {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(classForNib: DetailsViewControllerHeaderCell.self)
    }
}
// MARK: - UITableViewDelegate & UITableViewDataSource Methods
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch DetailsTableViewSections(rawValue: indexPath.section) {
        case .header:
            let cell: DetailsViewControllerHeaderCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(with: viewModel.getColorAsUIColor(), hexadecimal: viewModel.getColorAsHexadecimalString())
            return cell
        case .none: return UITableViewCell()
        }
    }
}
