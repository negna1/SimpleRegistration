//
//  SwiftUIView.swift
//  
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import SwiftUI
import Charts

struct ChartView: View {
    var body: some View {
        Chart {
            ForEach(departmentAProfit, id: \.date) { item in
                LineMark(
                    x: .value("Date", item.date),
                    y: .value("Profit A", item.profit),
                    series: .value("Company", "A")
                )
                .foregroundStyle(.blue)
            }
            ForEach(departmentBProfit, id: \.date) { item in
                LineMark(
                    x: .value("Date", item.date),
                    y: .value("Profit B", item.profit),
                    series: .value("Company", "B")
                )
                .foregroundStyle(.green)
            }
            RuleMark(
                y: .value("Threshold", 400)
            )
            .foregroundStyle(.red)
        }    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}


struct ProfitOverTime {
    var date: Date
    var profit: Double
}

let departmentAProfit: [ProfitOverTime] = [.init(date: .now, profit: 15), .init(date: secondDate, profit: 34)]
let departmentBProfit: [ProfitOverTime] = [.init(date: secondDate, profit: 24), .init(date: Date(), profit: 56)]

var secondDate: Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    
    return dateFormatter.date(from: "2023/02/13")!
}

