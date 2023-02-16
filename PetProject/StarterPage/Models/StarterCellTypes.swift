//
//  StarterCellTypes.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import UIKit
import Components

extension StarterController.CellModelType {
    
    var tableCellModel: TableCellModel {
        switch self {
            
        case .errorTitle(let title, let systemImageName):
            let labelType = RowItem.RowElementParam.init(title: title, color: .red)
            let leftElement = RowItem.ElementType.image(UIImage(systemName: systemImageName) ?? UIImage())
            let viewModel = RowItem.ViewModel(labels: .oneLine(labelType), left: leftElement)
            return RowTableCell.CellModel(rowItemModel: viewModel)
            
        case .title(let title):
            let labelType = RowItem.RowElementParam.init(title: title, font: .systemFont(ofSize: 20))
            let viewModel = RowItem.ViewModel(labels: .oneLine(labelType))
            return RowTableCell.CellModel(rowItemModel: viewModel)
        case .progressView(let currenValue, let totalValue):
            return ProgressPercentageTableCell.CellModel(currentValue: currenValue, totalValue: totalValue)
        case .button(viewModel: let viewModel):
            return ButtonTableCell.CellModel(viewModel: viewModel)
        case .textField(let viewModel):
            return TextFieldTableCell.CellModel(viewModel: viewModel)
        }
    }
}
 
extension StarterController {
    enum Section: CaseIterable {
        case initial
        case errorSection
    }
    
    enum CellModelType: Hashable {
        case title(String)
        case errorTitle(title: String, systemImageName: String)
        case progressView(currentValue: CGFloat, totalValue: CGFloat)
        case button(viewModel: ButtonView.ViewModel)
        case textField(viewModel: TextFieldUI.ViewModel)
    }
}

extension StarterController.CellModelType: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.tableCellModel.id == rhs.tableCellModel.id
    }
}
