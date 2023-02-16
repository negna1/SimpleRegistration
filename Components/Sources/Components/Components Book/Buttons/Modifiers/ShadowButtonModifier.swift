//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

struct ShadowButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(ShadowButtonStyle())
    }
}

extension View {
    var shadowButton: some View {
        modifier(ShadowButtonModifier())
    }
}
