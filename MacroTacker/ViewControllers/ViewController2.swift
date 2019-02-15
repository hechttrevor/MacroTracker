//
//  ViewController2.swift
//  MacroTacker
//
//  Created by Trevor Hecht on 2/13/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController2: UIViewController {

    var ref : DatabaseReference!
    let backgroundImageView = UIImageView()
    
    @IBOutlet weak var EnterFood: SATextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickFood(_ sender: Any) {
        let foodName = String(EnterFood.text!)
        if foodName.count == 0{
            showAlert(title: "Input Error", message: "Please enter a food")
            return
        }
        ref.child("Foods/\(foodName)").observeSingleEvent(of: .value, with: { (snapshot) in
            if(snapshot.exists()){
                let value = snapshot.value as? NSDictionary
                let calroies =  value?["calories"] as? Double ?? 0
                let protein =  value?["protein"] as? Double ?? 0
                let carbs =  value?["carbs"] as? Double ?? 0
                let fat =  value?["fat"] as? Double ?? 0
                let food = Foods(foodName: foodName,calories: calroies,protein: protein,carbs: carbs ,fat: fat)
                self.addToConsumed(food: food)
                return
            }else{
                self.showAlert(title: "Input Error", message: "We don't have this food on file, please enter it yourself")
                return
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addToConsumed(food: Foods){
        //check if has already been consumed
        let tmp = food.foodName
        var count = 0
        let nameCount = food.foodName.count
        ref.child("Consumed/").observeSingleEvent(of: .value, with: { (snapshot) in
            while(true){
                if(snapshot.hasChild("\(food.foodName)")){
                    count += 1
                    //let uuid = NSUUID().uuidString
                    
                    while food.foodName.count > nameCount{
                        food.foodName.remove(at: food.foodName.index(before: food.foodName.endIndex))
                    }
                    food.foodName += String(count)

                }else{
                    //add to consumed
                    self.ref.child("Consumed/\(food.foodName)").setValue(["calories": food.calories,"protein": food.protein, "carbs": food.carbs, "fat": food.fat])
                    self.showAlert(title: "Success", message: "You have added \(tmp) to your comsumed list")
                    return
            }
        }
        }) { (error) in
            print(error.localizedDescription)
        }

        
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
