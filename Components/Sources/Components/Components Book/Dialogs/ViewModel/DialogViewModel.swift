//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

extension DialogSwiftUI {
        public struct ViewModel {
            public init(id: UUID = UUID(),
                        title: String,
                        message: String?,
                        firstButtonType: ButtonView.ViewModel,
                        secondButtonType: ButtonView.ViewModel?) {
                self.id = id
                self.title = title
                self.message = message
                self.firstButtonType = firstButtonType
                self.secondButtonType = secondButtonType
            }
            
            public var id: UUID = UUID()
            var title: String
            var message: String?
            var firstButtonType: ButtonView.ViewModel
            var secondButtonType:  ButtonView.ViewModel?
        }
}

//MARK: - Hashable and equitable protocol confirm -
extension DialogSwiftUI.ViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
