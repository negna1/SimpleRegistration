//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI


public class ButtonView: UIView {

    func configure(viewModel: ViewModel) {
        let host = UIHostingController(rootView: ButtonSwiftUIView(viewModel: viewModel))
              let hostView = host.view!
              self.addSubview(hostView)
              
              hostView.snp.makeConstraints { make in
                  make.top.bottom.left.right.equalToSuperview()
                  make.height.equalTo(30)
              }
       }
}

