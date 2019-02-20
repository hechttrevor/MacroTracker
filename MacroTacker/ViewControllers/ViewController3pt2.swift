//
//  ViewController3pt2.swift
//  MacroTacker
//
//  Created by Trevor Hecht on 2/15/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import Charts

class ViewController3pt2: UIViewController {

    let backgroundImageView = UIImageView()
    
    @IBOutlet weak var goalChart: PieChartView!
    var proteinDataEntry = PieChartDataEntry(value: 50)
    var carbsDataEntry = PieChartDataEntry(value: 30)
    var fatDataEntry = PieChartDataEntry(value: 20)
    
    var totalMacro = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        updateChartData()
    }
    
    func updateChartData(){
        proteinDataEntry.label = "  % protein"
        carbsDataEntry.label = "% carbs"
        fatDataEntry.label = "% fat"
        
        totalMacro = [proteinDataEntry,carbsDataEntry,fatDataEntry]
        
        let chartDataSet = PieChartDataSet(values: totalMacro, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let greenColor = UIColor(red: 0, green: 165/255, blue: 0, alpha: 1)
        
        let colors = [greenColor, UIColor.orange, UIColor.blue]
        chartDataSet.colors = colors
        
        goalChart.data = chartData
    }
    
    func setBackground(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false //basiaclly lets you auto layout
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "background1")
        view.sendSubviewToBack(backgroundImageView)
    }
    
}
