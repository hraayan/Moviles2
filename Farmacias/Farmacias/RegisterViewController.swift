//
//  RegisterViewController.swift
//  Farmacias
//
//  Created by Mac2 on 22/06/21.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
class RegisterViewController: UIViewController {

    @IBOutlet weak var correoTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self

        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        
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
        GIDSignIn.sharedInstance()?.signIn()
    }
}


extension RegisterViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error ==  nil && user.authentication != nil{
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (resultado , error) in
                if let resultado = resultado, error == nil{
                    self.performSegue(withIdentifier: "registerDash", sender: self)
                }
            }
            
        }
    }
    
    
}
