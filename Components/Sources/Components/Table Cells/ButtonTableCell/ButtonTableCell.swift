//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import UIKit
import SnapKit

public class ButtonTableCell: UITableViewCell,  ConfigurableTableCell {

    private lazy var buttonView: ButtonView = {
        let txt = ButtonView()
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
        self.contentView.addSubview(buttonView)
        
        buttonView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview().inset(16)
        }
    }
    
    public func configure(with model: TableCellModel) {
        if let model = model as? CellModel {
            self.buttonView.configure(viewModel: model.viewModel)
        }
    }
}

extension ButtonTableCell {
    public struct CellModel: TableCellModel, Hashable {
        public static func == (lhs: CellModel, rhs: CellModel) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
         }
        
        public var nibIdentifier: String = ButtonTableCell.stringDescription
        public var height: Double = UITableView.automaticDimension
        public var viewModel: ButtonView.ViewModel
        public let id: UUID = UUID()
        public init(viewModel: ButtonView.ViewModel) {
            self.viewModel = viewModel
        }
    }
}



