//
//  EditViewController.swift
//  Noticias_noticias
//
//  Created by Mac2 on 18/04/21.
//

import UIKit

class EditViewController: UIViewController {
    
    var posi: Int?
    var arrNote:[String]?
    let defaultDB = UserDefaults.standard
    var reciveNote: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editaTaext.text = reciveNote
        //defaultDB.array(forKey: "notas") as? [String]
    }
    

    @IBOutlet weak var editaTaext: UITextField!
    
    
    @IBAction func updateButt(_ sender: Any) {
        //eliminar del arreglo nota a editar
        arrNote?.remove(at: posi!)
        print(arrNote)
        
        if let notaEditada = editaTaext.text{
            arrNote?.append(notaEditada)
        }
        
        
        
        print("Guardado")
        
        defaultDB.setValue(arrNote, forKey: "notas")
        navigationController?.popToRootViewController(animated: true)    }
}
