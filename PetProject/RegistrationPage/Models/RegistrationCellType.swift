//  
//  RegistrationCellType.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//


import UIKit
import Components



extension RegistrationController.CellModelType {
    
    var tableCellModel: TableCellModel {
        switch self {
            
        case .errorTitle(let title, let systemImageName):
            let labelType = RowItem.RowElementParam.init(title: title, color: .red)
            let leftElement = RowItem.ElementType.image(UIImage(systemName: systemImageName) ?? UIImage())
            let viewModel = RowItem.ViewModel(labels: .oneLine(labelType), left: leftElement)
            return RowTableCell.CellModel(rowItemModel: viewModel)
            
        case .title(let title):
            let labelType = RowItem.RowElementParam.init(title: title, font: .systemFont(ofSize: 15))
            let viewModel = RowItem.ViewModel(labels: .oneLine(labelType))
            return RowTableCell.CellModel(rowItemModel: viewModel)
        case .dateView(let viewModel):
            return DatePickerTableCell.CellModel(viewModel: viewModel)
        case .button(viewModel: let viewModel):
            return ButtonTableCell.CellModel(viewModel: viewModel)
        case .textField(let viewModel):
            return TextFieldTableCell.CellModel(viewModel: viewModel)
        }
    }
}
 
extension RegistrationController {
    enum Section: CaseIterable {
        case initial
        case errorSection
    }
    
    enum CellModelType: Hashable {
        case title(String)
        case errorTitle(title: String, systemImageName: String)
        case dateView(viewModel: DatePickerUI.ViewModel)
        case button(viewModel: ButtonView.ViewModel)
        case textField(viewModel: TextFieldUI.ViewModel)
    }
}

extension RegistrationController.CellModelType: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.tableCellModel.id == rhs.tableCellModel.id
    }
}
