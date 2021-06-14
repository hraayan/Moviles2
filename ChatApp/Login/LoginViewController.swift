//
//  LoginViewController.swift
//  Login
//
//  Created by marco rodriguez on 25/05/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var contraseñaTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        
        
        if let email = correoTF.text, let password = contraseñaTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
             
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    //NAvegar al inicio
                    self.performSegue(withIdentifier: "loginInicio", sender: self)
                }
                
            }
        }
        
    }
    

}
