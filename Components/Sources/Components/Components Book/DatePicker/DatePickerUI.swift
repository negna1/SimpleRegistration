//
//  SwiftUIView.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI

public struct DatePickerUI: View {
    @State var date: Date = .now
    @State var viewModel: ViewModel
    public  var body: some View {
        DatePicker(viewModel.title, selection: $date, displayedComponents: .date)
                .datePickerStyle(.automatic)
                .onChange(of: date) { newValue in
                    viewModel.action?(newValue)
                }.padding()
    }
}

struct DatePickerUI_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerUI(viewModel: .init(title: "enter your age", action: nil))
    }
}
