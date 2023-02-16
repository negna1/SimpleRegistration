//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

struct GradientTextFieldBackground: TextFieldStyle {
    
    let systemImage: Image
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(
                    LinearGradient(
                        colors: [
                            .red,
                            .blue
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 40)
            HStack {
                systemImage
                configuration
            }
            .padding(.leading)
            .foregroundColor(.gray)
        }
    }
}
