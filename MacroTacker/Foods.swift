//
//  Foods.swift
//  MacroTacker
//
//  Created by Trevor Hecht on 2/14/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit

class Foods: NSObject {
    var foodName: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
    
    init(foodName: String, calories: Double, protein: Double, carbs: Double, fat: Double) {
        self.foodName = foodName
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
    }
}
