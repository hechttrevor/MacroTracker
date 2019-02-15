//
//  ViewController.swift
//  MacroTacker HomePage 
//
//  Created by Trevor Hecht on 2/13/19.
//  Copyright © 2019 Trevor Hecht. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    let backgroundImageView = UIImageView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
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

