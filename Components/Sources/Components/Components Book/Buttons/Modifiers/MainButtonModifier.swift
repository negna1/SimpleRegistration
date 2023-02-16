//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

struct ButtonSwiftUIViewModifier: ViewModifier {
    var buttonType: ButtonView.ButtonType
    func body(content: Content) -> some View {
        switch buttonType {
        case .primaryButton:
            return  AnyView(content
                .frame(width: UIScreen.main.bounds.width - 64, height: 40)
                .primaryButton(isFlexible: false)
            )
            
        case .shadowButton:
            return AnyView(content.shadowButton)
        case .primaryButtonFlexible:
            return AnyView(content.primaryButton())
        }
    }
}


extension View {
    func buttonSwiftUIView(buttonType: ButtonView.ButtonType) -> some View {
        modifier(ButtonSwiftUIViewModifier(buttonType: buttonType))
    }
}
