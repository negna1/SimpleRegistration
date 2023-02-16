//
//  SwiftUIView.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

struct ProgressViewSwiftUI: View {
       var currentAmount: CGFloat
       var wholeAmount: CGFloat
       var percent: CGFloat {
              currentAmount/wholeAmount
       }
       @State var percentVal: CGFloat = 0
       var body: some View {
              VStack {
                     HStack {
                            Text(currentAmount.description)
                            ProgressView(value: percentVal, total: 1)
                                   .progressViewStyle(RoundedRectProgressViewStyle())
                                   .animation(.linear(duration: 2), value: percentVal)
                            Text(wholeAmount.description)
                     }
                           
                     
              }.onAppear {
                     percentVal = percent
              }
       }
}

struct RoundedRectProgressViewStyle: ProgressViewStyle {
       func makeBody(configuration: Configuration) -> some View {
              ZStack(alignment: .leading) {
                     RoundedRectangle(cornerRadius: 14)
                            .frame(width: 250, height: 28)
                            .foregroundColor(.blue)
                            .overlay(Color.black.opacity(0.5)).cornerRadius(14)
                     
                     RoundedRectangle(cornerRadius: 14)
                            .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 250, height: 28)
                            .foregroundColor(.yellow)
              }.animation(.linear, value: 2)
                     .padding()
       }
}

class ProgressPercentageView: UIView {

       func configure(currentValue: CGFloat, totalValue: CGFloat) {
              let host = UIHostingController(rootView: ProgressViewSwiftUI(currentAmount: currentValue, wholeAmount: totalValue))
              let hostView = host.view!
              self.addSubview(hostView)
              
              hostView.snp.makeConstraints { make in
                  make.top.bottom.left.right.equalToSuperview().offset(10)
                  make.height.equalTo(40)
              }
       }
       
}
