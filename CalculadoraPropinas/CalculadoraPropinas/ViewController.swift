//
//  ViewController.swift
//  CalculadoraPropinas
//
//  Created by Mac2 on 20/03/21.
//

import UIKit

class ViewController: UIViewController {

    var calculos = Calculos()
    @IBOutlet weak var totalText: UITextField!
    @IBOutlet weak var persoLabel: UILabel!
    @IBOutlet weak var porcentLabel: UILabel!
    @IBOutlet weak var personasSlid: UISlider!
    @IBOutlet weak var propinaSlid: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the +
    }
    
    @IBAction func propinaSlidAct(_ sender: UISlider) {
        porcentLabel.text = "\(String(format: "%.1f", sender.value)) %"
    }
    
    @IBAction func personasSlideActi(_ sender: UISlider) {
        persoLabel.text = "\(String(format: "%.0f", sender.value)) "
    }
    
    @IBAction func totTextActi(_ sender: UITextField) {
        
    }
    
    @IBAction func CalcularButton(_ sender: UIButton) {
        let tcuenta = Float(totalText.text!)
        //print(totalCuenta!)
        let porcentaje = propinaSlid.value
        let personas = Int(personasSlid.value)
        calculos.calculaPropina(tcuenta: tcuenta ?? 0.00, porcentaje: porcentaje, personas: personas)
        performSegue(withIdentifier: "resultado", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultado"{
            let destinoVC = segue.destination as! ResultViewController
            destinoVC.totalPropina = calculos.retornaPropina()
            destinoVC.totalPersona = calculos.retornaCuenta()
        }
    }
}
    
