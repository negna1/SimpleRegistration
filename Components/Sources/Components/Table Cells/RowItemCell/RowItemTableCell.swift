//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import UIKit
import SnapKit

public class RowTableCell: UITableViewCell,  ConfigurableTableCell {

    private lazy var rowItem: RowItem = {
        let txt = RowItem()
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.addSubview(rowItem)
        
        rowItem.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview().inset(6)
        }
    }
    
    public func configure(with model: TableCellModel) {
        if let model = model as? CellModel {
            self.rowItem.configure(with: model.rowItemModel)
        }
    }
}

extension RowTableCell {
    public struct CellModel: TableCellModel, Hashable {
        public static func == (lhs: CellModel, rhs: CellModel) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
         }
        
        public var nibIdentifier: String = "RowTableCell"
        public var height: Double = UITableView.automaticDimension
        public var rowItemModel: RowItem.ViewModel
        public let id: UUID = UUID()
        public init(rowItemModel: RowItem.ViewModel) {
            self.rowItemModel = rowItemModel
        }
    }
}

