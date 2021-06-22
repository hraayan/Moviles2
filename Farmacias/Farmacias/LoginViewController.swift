//
//  LoginViewController.swift
//  Farmacias
//
//  Created by Mac2 on 22/06/21.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet weak var correoTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func alertaMensaje(msj: String) {
        let alerta = UIAlertController(title: "ERROR", message: msj, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
    }

    @IBAction func LoginBtn(_ sender: UIButton) {
        if let email = correoTxt.text, let password = passwordTxt.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
             
                if let e = error {
                    print(e.localizedDescription)
                    self.alertaMensaje(msj: e.localizedDescription)
                    
                } else {
                    //NAvegar al inicio
                    self.performSegue(withIdentifier: "LoginDash", sender: self)
                }
                
            }
        }    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
    }
    
}
