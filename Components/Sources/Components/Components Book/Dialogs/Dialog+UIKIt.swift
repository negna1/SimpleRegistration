//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI


public class DialogView: UIView {

    public func configure(viewModel: DialogSwiftUI.ViewModel) {
        let host = UIHostingController(rootView: DialogSwiftUI(viewModel: viewModel))
              let hostView = host.view!
              self.addSubview(hostView)
              
              hostView.snp.makeConstraints { make in
                  make.top.bottom.left.right.equalToSuperview().offset(10)
                  make.height.equalTo(30)
              }
       }
}

public func getDialogController(viewModel: DialogSwiftUI.ViewModel) -> UIViewController {
    let vc: UIViewController = UIHostingController(rootView: DialogSwiftUI(viewModel: viewModel))
    vc.view.backgroundColor = .clear
    return vc
}

