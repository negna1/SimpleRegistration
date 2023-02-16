//  
//  ProfileCellType.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//


import UIKit
import Components



extension ProfileController.CellModelType {
    
    var tableCellModel: TableCellModel {
        switch self {
        case .title(let hit):
            let name = hit.user ?? ""
            let iconURL = URL(string: hit.userImageURL ?? "")
            let labelType = RowItem.RowElementParam.init(title: name, color: .black)
            let leftElement = RowItem.ElementType.remoteImage(url: iconURL)
            let viewModel = RowItem.ViewModel(labels: .oneLine(labelType), left: leftElement)
            return RowTableCell.CellModel(rowItemModel: viewModel)
        }
    }
}
 
extension ProfileController {
    enum Section: CaseIterable {
        case initial
    }
    
    enum CellModelType: Hashable {
        case title(hit: Hit)
    }
}

extension ProfileController.CellModelType: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.tableCellModel.id == rhs.tableCellModel.id
    }
}

extension Hit: Equatable, Hashable {
    static func == (lhs: Hit, rhs: Hit) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

