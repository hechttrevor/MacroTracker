//
//  ViewController3ViewController.swift
//  MacroTacker -- View Consumed Today 
//
//  Created by Trevor Hecht on 2/15/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import Charts
import FirebaseDatabase

class ViewController3: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var calories: UILabel!
    
    var ref : DatabaseReference!
    let backgroundImageView = UIImageView()

    var totalCalories = 0.0
    var totalProtein = 0.0
    var totalCarbs = 0.0
    var totalFat = 0.0
    
    var proteinPerc = 0.0
    var carbPerc = 0.0
    var fatPerc = 0.0
    
    var proteinDataEntry = PieChartDataEntry(value: 0)
    var carbsDataEntry = PieChartDataEntry(value: 0)
    var fatDataEntry = PieChartDataEntry(value: 0)
    
    var totalMacro = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        ref = Database.database().reference()
        setChart()

        updateChartData()
    }
    
    func setChart(/*completed: FinishedDownload*/){
        pieChart.chartDescription?.text = "Percentage Breakdown"
        ref.child("Consumed").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                self.ref.child("Consumed/\(snap.key)").observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snap.value as? NSDictionary
                    self.totalCalories +=  value?["calories"] as? Double ?? 0
                    self.totalProtein +=  value?["protein"] as? Double ?? 0
                    self.totalCarbs +=  value?["carbs"] as? Double ?? 0
                    self.totalFat +=  value?["fat"] as? Double ?? 0
                    
                    let total = self.totalProtein + self.totalCarbs + self.totalFat
                    self.proteinPerc = self.totalProtein/total
                    self.carbPerc = self.totalCarbs/total
                    self.fatPerc = self.totalFat/total
                    self.calories.text = "Total calories: \(Int(self.totalCalories))"
                    
                    self.updateChartData()
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    
//    func updateValues(calories: Double, protein: Double, carbs: Double, fat: Double){
//        totalCalories = calories
//        totalProtein = protein
//        totalCarbs = carbs
//        totalFat = fat
//        var total = calories + protein + carbs + fat
//
//
//        print(self.totalFat)
//    }

    func updateChartData(){
        proteinDataEntry.value = Double(round(1000*proteinPerc)/10)
        proteinDataEntry.label = "  % protein"
        carbsDataEntry.value = Double(round(1000*carbPerc)/10)
        carbsDataEntry.label = "% carbs"
        fatDataEntry.value = Double(round(1000*fatPerc)/10)
        fatDataEntry.label = "% fat"
        
        totalMacro = [proteinDataEntry,carbsDataEntry,fatDataEntry]
        
        let chartDataSet = PieChartDataSet(values: totalMacro, label: "")
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let greenColor = UIColor(red: 0, green: 165/255, blue: 0, alpha: 1)
        
        let colors = [greenColor, UIColor.orange, UIColor.blue]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    
    func showAlert(title : String, message: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
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
