//
//  LoginViewController.swift
//  Farmacias
//
//  Created by Mac2 on 22/06/21.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
class LoginViewController: UIViewController {

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

    @IBAction func LoginBtn(_ sender: UIButton) {
        if let email = correoTxt.text, let password = passwordTxt.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
             
                if let e = error {
                    print(e.localizedDescription)
                    self.alertaMensaje(msj: e.localizedDescription)
                    
                } else {
                    //NAvegar al inicio
                    self.performSegue(withIdentifier: "LoginDash", sender: self)
                    let defaults = UserDefaults.standard
                    defaults.set(email, forKey: "email")
                    defaults.synchronize()
                }
                
            }
        }    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

extension LoginViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error ==  nil && user.authentication != nil{
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (resultado , error) in
                if let resultado = resultado, error == nil{
                    self.performSegue(withIdentifier: "LoginDash", sender: self)
                }
            }
            
        }
    }
    
    
}
