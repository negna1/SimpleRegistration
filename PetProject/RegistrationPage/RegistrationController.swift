//  
//  RegistrationController.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Combine
import UIKit
import SnapKit
import Components
import SwiftUI

final class RegistrationController: UIViewController {
    private var cancellables: [AnyCancellable] = []
    private var viewModel: RegistrationViewModelType!
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var activityView: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.color = .red
        v.tintColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var dataSource = makeDataSource()
    private let selection = PassthroughSubject<CellModelType, Never>()
    
    public func bind(with viewModel: RegistrationViewModelType!) {
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
        tableView.register(ProgressPercentageTableCell.self,
                           forCellReuseIdentifier: ProgressPercentageTableCell.stringDescription)
        tableView.register(ButtonTableCell.self,
                           forCellReuseIdentifier: ButtonTableCell.stringDescription)
        
        tableView.register(TextFieldTableCell.self,
                           forCellReuseIdentifier: TextFieldTableCell.stringDescription)
        tableView.register(DatePickerTableCell.self, forCellReuseIdentifier: DatePickerTableCell.stringDescription)
        
    }
    
    private func bind(to viewModel: RegistrationViewModelType!) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let input = RegistrationViewModelInput()
        let output = viewModel.transform(input: input)
        
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: RegistrationState) {
        switch state {
        case .idle(let cells):
            update(with: cells, animate: false)
        case .validation(let cells):
            updateAlreadyCreated(with: cells, animate: true)
        case .showSuccess(let message):
            showSimpleAlert(title: Constant.success, message: message)
        case .showError(let message):
            showSimpleAlert(title: Constant.error, message: message)
        case .loading(let showIndicator):
            DispatchQueue.main.async {
                showIndicator ? self.activityView.startAnimating() :  self.activityView.stopAnimating()
            }
        }
    }
}

//MARK: - Data source and reload
extension RegistrationController {
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

//MARK: - Table View cell selection
extension RegistrationController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        
        selection.send(snapshot.itemIdentifiers[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Alert
extension RegistrationController {
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
extension RegistrationController {
    private func constrain() {
        constrainTableView()
        constrainActivityView()
    }
    
    private func constrainTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    private func constrainActivityView() {
        self.view.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(70)
        }
    }
}

//MARK: - Getters for test
extension RegistrationController{
    var getTableView: UITableView {
        tableView
    }
    
    var getDataSource: UITableViewDiffableDataSource<Section,  CellModelType> {
        dataSource
    }
}








