//
//  ViewController.swift
//  Farmacias
//
//  Created by Mac2 on 20/06/21.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String{
            performSegue(withIdentifier: "inicio", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        
    }


}

