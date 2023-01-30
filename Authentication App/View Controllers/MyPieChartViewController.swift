//
//  MyPieChartViewController.swift
//  Authentication App
//
//  Created by Raja Rai Kedarnathsingh on 22/09/2022.
//  Copyright © 2022 SBI. All rights reserved.
//

import UIKit
import Charts
import SwiftUI
import Firebase

class MyPieChartViewController: UIViewController, ChartViewDelegate {
    
    @ObservedObject var expenseViewModel = ExpenseViewModel()
    var expenses = [Expense]()
    @IBOutlet weak var pieUIView: UIView!
    
    var pieChart = PieChartView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let months = ["Medical test", "Car loan", "Uber ride", "Ice cream", "Coffee"]
        let price = [1000, 500, 100, 120, 140]

        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entries = [ChartDataEntry]()
        
        for x in 0..<price.count {
            let dataEntry = PieChartDataEntry(value: Double(price[x]), label: months[x])
            entries.append(dataEntry)
        }
        
        
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.pastel()
        
        let data = PieChartData(dataSet: set)
        
        pieChart.centerText = "Amount Spent-Rs4000 "
        pieChart.data = data
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.multiplier = 1.0
        formatter.percentSymbol = "%"
        formatter.zeroSymbol = ""
        
        data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        pieChart.usePercentValuesEnabled = true
        pieChart.animate(yAxisDuration: 2.0, easingOption: .easeOutExpo)
    }
}

func populateExpenses() {
//    Expense expense = new Expense(id: <#T##String#>, description: <#T##String?#>, price: <#T##Float#>)
//    ["userEmail": jon.doe@gmail.com, "description": Medical test, "price": 1000]
//    ["price": 100000, "userEmail": jon.doe@gmail.com, "description": Car]
//    ["price": 1234, "userEmail": jon.doe@gmail.com, "description": Jon doe]
//    ["price": 2313, "userEmail": jon.doe@gmail.com, "description": Uber ride]
//    ["price": 120, "userEmail": jon.doe@gmail.com, "description": Updated:Ice cream]
}
