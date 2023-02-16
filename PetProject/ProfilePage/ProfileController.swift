//  
//  ProfileController.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Combine
import UIKit
import SnapKit
import Components
import SwiftUI

final class ProfileController: UIViewController {
    private var cancellables: [AnyCancellable] = []
    private var viewModel: ProfileViewModelType!
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
    
    public func bind(with viewModel: ProfileViewModelType!) {
        self.viewModel = viewModel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .orange,
                               tintColor: .blue,
                               title: Constant.title,
                               preferredLargeTitle: true)
        self.navigationItem.setHidesBackButton(true, animated: false)
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
        
    }
    
    private func bind(to viewModel: ProfileViewModelType!) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let input = ProfileViewModelInput(selection: selection.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: ProfileState) {
        switch state {
        case .idle(let cells):
            update(with: cells, animate: false)
        case .showError(let message):
            showSimpleAlert(title: Constant.error, message: message)
        case .isLoading(let show):
            DispatchQueue.main.async {
                show ? self.activityView.startAnimating() :  self.activityView.stopAnimating()
            }
        }
    }
}
 
//MARK: - Data source and reload
 extension ProfileController {
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

//MARK: - Table View cell selection
extension ProfileController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        
        selection.send(snapshot.itemIdentifiers[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Alert
extension ProfileController {
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
extension ProfileController {
    private func constrain() {
        constrainTableView()
        constrainActivityView()
    }
    
    private func constrainTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
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








