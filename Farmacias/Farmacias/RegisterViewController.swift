//
//  RegisterViewController.swift
//  Farmacias
//
//  Created by Mac2 on 22/06/21.
//

import UIKit
import Firebase
import FirebaseAuth
class RegisterViewController: UIViewController {

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
    
    @IBAction func registerBtn(_ sender: UIButton) {
        if let email = correoTxt.text, let password = passwordTxt.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print("Error al crear usuario \(e.localizedDescription)")
                    if e.localizedDescription == "The email address is already in use by another account." {
                        self.alertaMensaje(msj: "Ese correo ya esta en uso, favor de crear otro")
                    } else if e.localizedDescription == "The email address is badly formatted." {
                        self.alertaMensaje(msj: "Verifica el formato de tu email")
                    } else if e.localizedDescription == "The password must be 6 characters long or more." {
                        self.alertaMensaje(msj: "Tu contraseña debe de ser de 6 caracteres o mas")
                    }
                    
                } else {
                    //Navegar al siguiente VC
                    self.performSegue(withIdentifier: "registerDash", sender: self)
                }
                
            }
        }
    }
    
    @IBAction func googleRegister(_ sender: UIButton) {
    }
    
    }
