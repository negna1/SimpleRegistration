//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    var backgroundColor: Color
    var titleColor: Color
    var needClickedAnimation: Bool
    func body(content: Content) -> some View {
            content
            .font(.body)
                .foregroundColor(.white)
                .padding([.leading, .trailing])
                .padding([.top, .bottom], 2)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                .buttonStyle(needClickedAnimation ? ShadowButtonStyle() : .init())
        
    }
}

struct PrimaryButtonTitleModifier: ViewModifier {
    var isPrimary: Bool
    func body(content: Content) -> some View {
        if isPrimary {
            GeometryReader { geometryProxy in
                content
                .font(.body)
                .frame(width: geometryProxy.size.width)
                .padding([.top, .bottom], 10) // vertical padding
                .background(Color.black)
                .cornerRadius(6)
                }
        }else {
            content
        }
        
        
    }
}

   

extension View {
    func primaryButtonTitleModifier(isPrimary: Bool = true) -> some View {
        modifier(PrimaryButtonTitleModifier(isPrimary: isPrimary))
    }
    
    func primaryButton(
        isFlexible: Bool = true,
        backgroundColor: Color = .black,
        titleColor: Color = .white) -> some View {
            modifier(PrimaryButtonModifier(
                backgroundColor: backgroundColor,
                titleColor: titleColor,
                needClickedAnimation: true))
        }
}


