//
//  TabViewController.swift
//  Farmacias
//
//  Created by Mac2 on 25/06/21.
//

import UIKit
import Firebase
import FirebaseAuth
class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
    }
    
    @IBAction func salirBtn(_ sender: UIBarButtonItem) {
        
        //borrar datos de sesion
        let defualts = UserDefaults.standard
        defualts.removeObject(forKey: "email")
        defualts.synchronize()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Cerro sesion correctamente!")
            navigationController?.popToRootViewController(animated: true)
        } catch let error as NSError {
            print ("Error al cerrar sesion\(error.localizedDescription)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
