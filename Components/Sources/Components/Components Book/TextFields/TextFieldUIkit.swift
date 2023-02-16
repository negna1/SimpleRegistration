//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

public class TextFieldView: UIView {
    
    func configure(viewModel: TextFieldUI.ViewModel) {
      
        switch viewModel.textFieldType {
        case .password:
            let  host = UIHostingController(rootView: SecuredUI(viewModel: viewModel))
            let hostView = host.view!
            self.addSubview(hostView)
            
            hostView.snp.makeConstraints { make in
                make.top.bottom.left.right.equalToSuperview()
                make.height.equalTo(30)
            }
        default:
            let  host = UIHostingController(rootView: TextFieldUI(viewModel: viewModel))
            let hostView = host.view!
            self.addSubview(hostView)
            
            hostView.snp.makeConstraints { make in
                make.top.bottom.left.right.equalToSuperview()
                make.height.equalTo(30)
            }
        }
    }
}

