//  
//  ProfileDetailsController.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 16.02.23.
//

import Combine
import UIKit
import SnapKit
import Components
import SwiftUI

final class ProfileDetailsController: UIViewController {
    private var cancellables: [AnyCancellable] = []
    private var viewModel: ProfileDetailsViewModelType!
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    private lazy var dataSource = makeDataSource()
    
    public func bind(with viewModel: ProfileDetailsViewModelType!) {
        self.viewModel = viewModel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .orange,
                               tintColor: .blue,
                               title: Constant.title,
                               preferredLargeTitle: true)
    }
    
    override func viewDidLoad() {
        configureUI()
        bind(to: viewModel)
    }
    
    private func configureUI() {
        constrain()
        registerCells()
        tableView.dataSource = dataSource
    }
    
    private func registerCells() {
        tableView.register(RowTableCell.self,
                           forCellReuseIdentifier: RowTableCell.stringDescription)
        
    }
    
    private func bind(to viewModel: ProfileDetailsViewModelType!) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let output = viewModel.transform()
        
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: ProfileDetailsState) {
        switch state {
        case .idle(let cells):
            update(with: cells, animate: false)
        }
    }
}

//MARK: - Data source and reload
extension ProfileDetailsController {
    func makeDataSource() -> UITableViewDiffableDataSource<Section,  CellModelType> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, type in
                let cell = tableView.dequeueReusableCell(withIdentifier: type.tableCellModel.nibIdentifier) as? ConfigurableTableCell
                cell?.configure(with: type.tableCellModel)
                return cell ?? UITableViewCell()
            }
        )
    }
    
    func update(with models: [CellModelType], animate: Bool) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section,  CellModelType>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(models, toSection: .initial)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}

//MARK: - Constrain
extension ProfileDetailsController {
    private func constrain() {
        constrainTableView()
    }
    private func constrainTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
}








