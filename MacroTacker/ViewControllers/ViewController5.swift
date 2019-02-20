//
//  ViewController5.swift
//  MacroTacker - Add food
//
//  Created by Trevor Hecht on 2/14/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController5: UIViewController {

    let backgroundImageView = UIImageView()
    var ref : DatabaseReference!
    @IBOutlet weak var foodNameText: UITextField!
    @IBOutlet weak var caloriesText: UITextField!
    @IBOutlet weak var proteinText: UITextField!
    @IBOutlet weak var carbsText: UITextField!
    @IBOutlet weak var fatText: UITextField!
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickAddFood(_ sender: Any) {
        let foodTxt = String(foodNameText.text!)
        if foodTxt.count == 0 {
            showAlert(title:"Input Error", message: "Please enter the food's name")
            return
        }
        guard let calariesNumb = Double(caloriesText.text!) else{
            showAlert(title:"Input Error", message: "Please enter the number of calories")
            return
        }
        guard let proteinNumb = Double(proteinText.text!) else{
            showAlert(title:"Input Error", message: "Please enter the number of protein")
            return
        }
        guard let carbsNumb = Double(carbsText.text!) else{
            showAlert(title:"Input Error", message: "Please enter the number of carbs")
            return
        }
        guard let fatNumb = Double(fatText.text!) else{
            showAlert(title:"Input Error", message: "Please enter the number of fat")
            return
        }
        
        ref.child("Foods/\(foodTxt)").observeSingleEvent(of: .value, with: { (snapshot) in
            if(snapshot.exists()){
                self.showAlertYesNo(title: "\(foodTxt) already exists", message: "Proceeding will overwrite \(foodTxt)'s information", foodTxt: foodTxt, calariesNumb: calariesNumb, proteinNumb: proteinNumb, carbsNumb: carbsNumb, fatNumb: fatNumb)

                
            }else{
                self.addToDataBase(foodTxt: foodTxt, calariesNumb: calariesNumb, proteinNumb: proteinNumb, carbsNumb: carbsNumb, fatNumb: fatNumb)
            }
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    func addToDataBase(foodTxt:String, calariesNumb: Double, proteinNumb: Double, carbsNumb: Double, fatNumb: Double){
        self.ref.child("Foods/\(foodTxt)").setValue(["calories": calariesNumb,"protein": proteinNumb, "carbs": carbsNumb, "fat": fatNumb])
        showAlert(title: "Success", message: "\(foodTxt) added to the food list")
    }
    
    
    func showAlertYesNo(title : String, message: String, foodTxt:String, calariesNumb: Double, proteinNumb: Double, carbsNumb: Double, fatNumb: Double){
        var refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.addToDataBase(foodTxt: foodTxt, calariesNumb: calariesNumb, proteinNumb: proteinNumb, carbsNumb: carbsNumb, fatNumb: fatNumb)
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
           return
        }))

        present(refreshAlert, animated: true, completion: nil)
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
