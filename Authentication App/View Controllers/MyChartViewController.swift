//
//  MyChartViewController.swift
//  Authentication App
//
//  Created by Raja Rai Kedarnathsingh on 22/09/2022.
//  Copyright © 2022 SBI. All rights reserved.
//

import UIKit
import Charts

class MyChartViewController: UIViewController, ChartViewDelegate {

    var barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        barChart.center = view.center
        view.addSubview(barChart)
        
        var entries = [BarChartDataEntry]()
        
        for x in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.joyful()

        
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        barChart.animate(yAxisDuration: 2.0, easingOption: .easeOutExpo)
    }
}
