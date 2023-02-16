//
//  SwiftUIView.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

struct ButtonSwiftUIView: View {
    
    var viewModel: ButtonView.ViewModel
    var body: some View {
        Button {
            viewModel.action?()
        } label: {
            Text(viewModel.title)
                .primaryButtonTitleModifier(isPrimary: viewModel.buttonType != .shadowButton)
            
        }.buttonSwiftUIView(buttonType: viewModel.buttonType)
    }
}

struct ButtonSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonSwiftUIView(viewModel: .init(title: "efvrervrevrvrverv", buttonType: .primaryButtonFlexible))
    }
}


