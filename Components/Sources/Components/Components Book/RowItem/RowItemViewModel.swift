//
//  File.swift
//  
//
// Created by Nato Egnatashvili on 15.02.23.
//

import Foundation
import UIKit

extension RowItem {
    public struct ViewModel {
        public init(needSeparator: Bool = false,
                      labels: RowItem.LabelType,
                      left: RowItem.ElementType? = nil,
                      right: RowItem.ElementType? = nil) {
            self.needSeparator = needSeparator
            self.labels = labels
            self.left = left
            self.right = right
        }
        
        var needSeparator: Bool
        var labels: LabelType
        var left: ElementType? = nil
        var right: ElementType? = nil
    }
    
    public enum ElementType {
        case title(RowElementParam)
        case image(UIImage, width: CGFloat = 30)
        case remoteImage(url: URL?, width: CGFloat = 50)
    }
    
    public enum LabelType {
        case oneLine(RowElementParam)
        case twoLine(RowElementParam, RowElementParam)
        case threeLine(RowElementParam, RowElementParam, RowElementParam)
    }
    
    public struct RowElementParam {
        public init(title: String, color: UIColor = .black, font: UIFont = .systemFont(ofSize: 12)) {
            self.title = title
            self.color = color
            self.font = font
        }
        
        var title: String
        var color: UIColor
        var font: UIFont
    }
}
