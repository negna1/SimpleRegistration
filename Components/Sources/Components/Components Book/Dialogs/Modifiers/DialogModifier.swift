//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

struct CustomDialog<DialogContent: View>: ViewModifier {
  @Binding var isShowing: Bool
  let dialogContent: DialogContent

  init(isShowing: Binding<Bool>,
        @ViewBuilder dialogContent: () -> DialogContent) {
    _isShowing = isShowing
     self.dialogContent = dialogContent()
  }

  func body(content: Content) -> some View {
    ZStack {
      content
      if isShowing {
        Rectangle().foregroundColor(Color.black.opacity(0.6))
        ZStack {
          dialogContent
            .background(
              RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.white))
        }.padding(40)
      }
    }
  }
}

extension View {
  func customDialog<DialogContent: View>(
    isShowing: Binding<Bool>,
    @ViewBuilder dialogContent: @escaping () -> DialogContent
  ) -> some View {
    self.modifier(CustomDialog(isShowing: isShowing, dialogContent: dialogContent))
  }
}
