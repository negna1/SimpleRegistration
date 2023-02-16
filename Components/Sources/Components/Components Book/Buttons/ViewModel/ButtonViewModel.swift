//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation

extension ButtonView {
    public enum ButtonType {
        case primaryButton
        case primaryButtonFlexible
        case shadowButton
    }
    
    public struct ViewModel {
        public init(id: UUID = UUID(),
                    title: String,
                    action: (() -> ())? = nil,
                    buttonType: ButtonView.ButtonType) {
            self.id = id
            self.title = title
            self.action = action
            self.buttonType = buttonType
        }
        
        var id: UUID = UUID()
        var title: String
        var action: (() -> ())?
        var buttonType: ButtonType
    }
}

//MARK: - Hashable and equitable protocol confirm -
extension ButtonView.ViewModel: Hashable {
    public static func == (lhs: ButtonView.ViewModel, rhs: ButtonView.ViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
