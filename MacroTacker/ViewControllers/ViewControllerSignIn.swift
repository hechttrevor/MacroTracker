//
//  ViewControllerSignIn.swift
//  MacroTacker
//
//  Created by Trevor Hecht on 2/18/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewControllerSignIn: UIViewController {
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    var username = ""
    let backgroundImageView = UIImageView()
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
    
    @IBAction func signUp(_ sender: Any) {
        username = userNameTxt.text!
        performSegue(withIdentifier: "signup", sender: self)
    }
    
    @IBAction func logIn(_ sender: Any) {
//        vc.text = "Trev"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! ViewController
        vc.finalUsername = self.username
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
