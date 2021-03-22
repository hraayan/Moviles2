//
//  ResultViewController.swift
//  CalculadoraPropinas
//
//  Created by Mac2 on 21/03/21.
//

import UIKit



class ResultViewController: UIViewController {
    
    var totalPropina: String?
    var totalPersona: String?
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var Persona: UILabel!
    @IBOutlet weak var backButt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Total.text = totalPropina
        Persona.text = totalPersona
    }
    

    @IBAction func BackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
