//
//  EachFarmaViewController.swift
//  Farmacias
//
//  Created by Mac2 on 30/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore
class EachFarmaViewController: UIViewController {

    var idRecive: String?
    @IBOutlet weak var labl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labl.text = idRecive
        print("id: \(idRecive)")

        // Do any additional setup after loading the view.
    }
    

    

}
