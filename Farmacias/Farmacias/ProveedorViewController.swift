//
//  ProveedorViewController.swift
//  Farmacias
//
//  Created by Mac2 on 01/07/21.
//

import UIKit
import Firebase
import FirebaseFirestore
struct Proveeds: Decodable {
    let id: Int
    let Nombre: String
    let RFC: String
    let Telefono: String
    let Direccion: String
    let Ciudad: String
    let Estado: String
    let CP: String
    let Correo: String
    let Linea: String
    let UrlImg: String?
}
struct Provees: Decodable{
    var document: [Proveeds]
}
class ProveedorViewController: UIViewController {

    @IBOutlet weak var imgProv: UIImageView!
    var proveedores = [Provees]()
    let db = Firestore.firestore()
    @IBOutlet weak var labl: UILabel!
    var idRecive: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarProveedor()
        
    }
    
    @IBOutlet weak var EdoText: UITextField!
    @IBOutlet weak var rfcText: UITextField!
    @IBOutlet weak var ciudadText: UITextField!
    @IBOutlet weak var nombreText: UITextField!
    
    @IBOutlet weak var TeleText: UITextField!
    @IBOutlet weak var CodPText: UITextField!
    @IBOutlet weak var directText: UITextField!
    
    @IBOutlet weak var imgurlText: UITextField!
    @IBOutlet weak var lineaText: UITextField!
    @IBOutlet weak var correoText: UITextField!
    func cargarProveedor(){
        let docRef = db.collection("proveedores").document("\(idRecive!)")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.nombreText.text = "\(document.data()?["Nombre"] ?? "No Encontrado" )"
                self.rfcText.text = "\(document.data()?["RFC"] ?? "No Encontrado" )"
                self.EdoText.text = "\(document.data()?["Estado"] ?? "No Encontrado" )"
                self.ciudadText.text = "\(document.data()?["Ciudad"] ?? "No Encontrado" )"
                self.directText.text = "\(document.data()?["Direccion"] ?? "No Encontrado" )"
                self.CodPText.text = "\(document.data()?["CP"] ?? "No Encontrado" )"
                self.TeleText.text = "\(document.data()?["Telefono"] ?? "No Encontrado" )"
                self.correoText.text = "\(document.data()?["Correo"] ?? "No Encontrado" )"
                self.lineaText.text = "\(document.data()?["Linea"] ?? "No Encontrado" )"
                self.imgurlText.text = "\(document.data()?["urlimg"] ?? "No Encontrado" )"
                
                if let urlimg = document.data()?["urlimg"] as? String{
                    let url = URL(string: urlimg)
                    let imgalr = URL(string:"https://incresc.com/images/incresc/fondo_sin_imagen_perfil_usuario.png")
                    let data = try? Data(contentsOf: url ?? imgalr!)
                    
                    DispatchQueue.main.async {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.imgProv.image = image
                            
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
        
        }
    @IBAction func updateBtn(_ sender: UIButton) {
        
        self.db.collection("proveedores").document("\(idRecive!)").setData([
            "Nombre": nombreText.text,
            "Estado": EdoText.text ,
            "Ciudad": ciudadText.text,
            "Direccion": directText.text ,
            "Telefono" : TeleText.text ,
            "CP": CodPText.text  ,
            "RFC" : rfcText.text ,
            "Correo" : correoText.text ,
            "Linea" :lineaText.text,
            "urlimg": imgurlText.text
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
                let alerta = UIAlertController(title: "Error al registrar", message: "\(err)", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                self.present(alerta, animated: true, completion: nil)
            } else {
                print("Document successfully written!")
                let alerta = UIAlertController(title: "Agregado Correctamente", message: nil, preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                self.present(alerta, animated: true, completion: nil)
                
            }
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
