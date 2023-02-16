//
//  StarterController.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Combine
import UIKit
import SnapKit
import Components
import SwiftUI

final class StarterController: UIViewController {
    private var cancellables: [AnyCancellable] = []
    private var viewModel: StarterViewModelType!
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    private lazy var dataSource = makeDataSource()
    
    public func bind(with viewModel: StarterViewModelType!) {
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
        tableView.register(ButtonTableCell.self,
                           forCellReuseIdentifier: ButtonTableCell.stringDescription)
        
        tableView.register(TextFieldTableCell.self,
                           forCellReuseIdentifier: TextFieldTableCell.stringDescription)
        
    }
    
    private func bind(to viewModel: StarterViewModelType) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let input = StarterViewModelInput()
        let output = viewModel.transform(input: input)
        
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: StarterPageState) {
        switch state {
        case .idle(let cells):
            update(with: cells, animate: false)
        case .validation(let cells):
            updateAlreadyCreated(with: cells, animate: true)
        case .showError(let message):
            showSimpleAlert(title: Constant.error, message: message)
        }
    }
}

//MARK: - Data source and reload
extension StarterController {
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
    
    func updateAlreadyCreated(with models: [CellModelType], animate: Bool) {
        DispatchQueue.main.async {
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteSections([.errorSection])
            snapshot.appendSections([.errorSection])
            snapshot.appendItems(models, toSection: .errorSection)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}

//MARK: - Alert
extension StarterController {
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Done",
                                      style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - Constrain
extension StarterController {
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
