//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

public class DatePickerView: UIView {
    
    public func configure(viewModel: DatePickerUI.ViewModel) {
        let  host = UIHostingController(rootView: DatePickerUI(viewModel: viewModel))
        let hostView = host.view!
        self.addSubview(hostView)
        
        hostView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}
