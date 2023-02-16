//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//
import SwiftUI

extension TextFieldUI {
    public enum TextfieldType {
        case username
        case password
        case email
        case custom(Image)
    }
        public struct ViewModel {
            public init(id: UUID = UUID(),
                        title: String,
                        textFieldType: TextfieldType,
                        action: ((String) -> ())? ) {
                self.id = id
                self.title = title
                self.textFieldType = textFieldType
                self.action = action
            }
            
            public var id: UUID = UUID()
            var title: String
            var textFieldType: TextfieldType
            var action: ((String) -> ())?
        }
}

//MARK: - Hashable and equitable protocol confirm -
extension TextFieldUI.ViewModel: Hashable {
    public static func == (lhs: TextFieldUI.ViewModel, rhs: TextFieldUI.ViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TextFieldUI.TextfieldType {
    var icon: Image {
        switch self {
        case .username:
            return Image(systemName: "person")
        case .password:
            return Image(systemName: "exclamationmark.lock.fill")
        case .email:
            return  Image(systemName: "envelope")
        case .custom(let image):
            return image
        }
    }
}
