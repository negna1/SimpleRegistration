//
//  SwiftUIView.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

public struct TextFieldUI: View {
    @State var name = ""
    @State var viewModel: ViewModel
    public var body: some View {
        VStack {
            // MARK: - Name TextField
            TextField(viewModel.title, text: $name)
                .textFieldStyle(
                    GradientTextFieldBackground(
                        systemImage: viewModel.textFieldType.icon
                    )
                ).onChange(of: name) { newValue in
                    viewModel.action?(newValue)
                }
        }
        .padding()
    }
}

public struct SecuredUI: View {
    @State var name = ""
    @State var viewModel: TextFieldUI.ViewModel
    public var body: some View {
        VStack {
            // MARK: - Name TextField
            SecureField(viewModel.title, text: $name)
                .textFieldStyle(
                    GradientTextFieldBackground(
                        systemImage: viewModel.textFieldType.icon
                    )
                ).onChange(of: name) { newValue in
                    viewModel.action?(newValue)
                }
        }
        .padding()
    }
}

struct TextFieldUI_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldUI(viewModel: .init(title: "Username", textFieldType: .username, action: { change in
            print(change)
        }))
    }
}
