//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import UIKit
import SnapKit

public class ProgressPercentageTableCell: UITableViewCell,  ConfigurableTableCell {

    private lazy var rowItem: ProgressPercentageView = {
        let txt = ProgressPercentageView()
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
            self.rowItem.configure(currentValue: model.currentValue, totalValue: model.totalValue)
        }
    }
}

extension ProgressPercentageTableCell {
    public struct CellModel: TableCellModel, Hashable {
        public static func == (lhs: CellModel, rhs: CellModel) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
         }
        
        public var nibIdentifier: String = ProgressPercentageTableCell.stringDescription
        public var height: Double = UITableView.automaticDimension
        public var currentValue: CGFloat
        public var totalValue: CGFloat
        public let id: UUID = UUID()
        public init(currentValue: CGFloat, totalValue: CGFloat) {
            self.currentValue = currentValue
            self.totalValue = totalValue
        }
    }
}



