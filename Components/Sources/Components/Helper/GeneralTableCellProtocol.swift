//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import UIKit


public struct TableSection {
    var header: TableHeaderFooterModel?
    var cells: [ TableCellModel]
    var footer: TableHeaderFooterModel?
    
    init(header: TableHeaderFooterModel? = nil,
         cells: [ TableCellModel],
         footer: TableHeaderFooterModel? = nil) {
        self.header = header
        self.cells = cells
        self.footer = footer
    }
}

public protocol TableHeaderFooterModel {
    var nibIdentifier: String { get }
    var height: Double { get }
}


public protocol TableCellModel {
    var nibIdentifier: String { get }
    var height: Double { get }
    var id: UUID { get }
}

extension TableCellModel {
    public var id: UUID {
        return UUID()
    }
}


public protocol ConfigurableTableHeaderFooter {
    func configure(with model: TableHeaderFooterModel)
}


public protocol ConfigurableTableCell: UITableViewCell {
    func configure(with model: TableCellModel)
}

extension UITableViewCell {
    public static var stringDescription: String {
        String(describing: self)
    }
}

