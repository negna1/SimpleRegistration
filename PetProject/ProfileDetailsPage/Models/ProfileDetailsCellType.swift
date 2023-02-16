//  
//  ProfileDetailsCellType.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 16.02.23.
//


import UIKit
import Components



extension ProfileDetailsController.CellModelType {
    
    var tableCellModel: TableCellModel {
        switch self {
        case .infoRowItem(let title, let value, let systemNameImage):
            let labelType = RowItem.RowElementParam.init(title: title)
            let rightValue = RowItem.RowElementParam.init(title: value)
            let leftIcon = RowItem.ElementType.image(UIImage(systemName: systemNameImage) ?? UIImage())
            let rightElement = RowItem.ElementType.title(rightValue)
            let viewModel = RowItem.ViewModel(labels: .oneLine(labelType),
                                              left: leftIcon,
                                              right: rightElement)
            return RowTableCell.CellModel(rowItemModel: viewModel)
        case .bigTitle(let title):
            let labelType = RowItem.RowElementParam.init(title: title, font: .systemFont(ofSize: 25))
            let viewModel = RowItem.ViewModel(labels: .oneLine(labelType))
            return RowTableCell.CellModel(rowItemModel: viewModel)
        case .title(let hit):
            let labelType = RowItem.RowElementParam.init(title: "Image Size: \(hit.imageSize ?? 0)")
            let typel = RowItem.RowElementParam.init(title: "Image type: \(hit.type?.rawValue ?? "")")
            let tags = RowItem.RowElementParam.init(title: "Image tags \(hit.tags ?? "")")
            let leftIcon = RowItem.ElementType.remoteImage(url: URL(string: hit.userImageURL ?? ""),
                                                           width: 100)
            let viewModel = RowItem.ViewModel(needSeparator: true, labels: .threeLine(labelType, typel, tags), left: leftIcon)
            return RowTableCell.CellModel(rowItemModel: viewModel)
        }
    }
}
 
extension ProfileDetailsController {
    enum Section: CaseIterable {
        case initial
    }
    
    enum CellModelType: Hashable {
        case bigTitle(title: String)
        case title(hit: Hit)
        case infoRowItem(title: String, value: String, systemNameImage: String)
    }
}

extension ProfileDetailsController.CellModelType: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.tableCellModel.id == rhs.tableCellModel.id
    }
}
