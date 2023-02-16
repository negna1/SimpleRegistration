//
//  SwiftUIView.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

public struct DialogSwiftUI: View {
    var viewModel: ViewModel
  @State private var showDialog = true
  public var body: some View {
    EmptyView().customDialog(isShowing: $showDialog) {
      VStack {
          Text(viewModel.title)
          .fontWeight(.bold)
        Divider()
          Text(viewModel.message ?? "")
          .padding(.bottom, 10)
          HStack {
              ButtonSwiftUIView(viewModel: viewModel.firstButtonType)
              if let model = viewModel.secondButtonType {
                  ButtonSwiftUIView(viewModel: model)
              }
          }
          
      }.padding()
    }
  }
}

struct DialogSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        DialogSwiftUI(viewModel: .init(title: "Dialog is this", message: "Please remove or cancel", firstButtonType: .init(title: "close", buttonType: .shadowButton), secondButtonType: .init(title: "confirm", buttonType: .primaryButtonFlexible)))
    }
}

