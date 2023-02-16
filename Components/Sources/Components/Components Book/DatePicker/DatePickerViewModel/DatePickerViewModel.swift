//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//


import SwiftUI

extension DatePickerUI {
        public struct ViewModel {
            public init(id: UUID = UUID(),
                        title: String,
                        action: ((Date) -> ())? ) {
                self.id = id
                self.title = title
                self.action = action
            }
            
            public var id: UUID = UUID()
            var title: String
            var action: ((Date) -> ())?
        }
}

//MARK: - Hashable and equitable protocol confirm -
extension DatePickerUI.ViewModel: Hashable {
    public static func == (lhs: DatePickerUI.ViewModel, rhs: DatePickerUI.ViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
