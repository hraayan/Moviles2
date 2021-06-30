//
//  FarmaciaViewController.swift
//  Farmacias
//
//  Created by Mac2 on 24/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore
class FarmaciaViewController: UIViewController {

    
    var farmacias = [Farmacia]()
    
    //Agregar la referencia a la BD Firestore
    let db = Firestore.firestore()
    @IBOutlet weak var tablaFarmacia: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tablaFarmacia.register(nib, forCellReuseIdentifier: "FarmaCell")
        //ocultar el boton de regresar
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor =  view.backgroundColor
        cargarFarmacias()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        cargarFarmacias()
        
    }
    func cargarFarmacias(){
        db.collection("farmacia").addSnapshotListener() { (querySnapshot, err) in
                //Vaciar arreglo de chats
                self.farmacias = []
                
            if let e = err {
                print("Error al obtener los chats: \(e.localizedDescription)")
            } else {
                if let snapshotDocumentos = querySnapshot?.documents {
                    for document in snapshotDocumentos {
                        //crear mi objeto mensaje
                        let datos = document.data()
                        print("ID \(document.documentID)")
                        print(datos)
                         //Sacar los parametros p obj Mensaje
                        guard let  id = document.documentID as? String else { return }
                        guard let  direc = datos["Direccion"] as? String else { return }
                        guard let ciudad = datos["Ciudad"] as? String else { return }
                        guard let estado = datos["Estado"] as? String else { return }
                        guard let telefono = datos["Telefono"] as? Int64 else { return }
                        guard let nombre = datos["Nombre"] as? String else { return }
                        let farmaci = Farmacia(id:id, Nombre: nombre, Ciudad: ciudad, Estado: estado,Direccion: direc, Telefono: telefono)

                        self.farmacias.append(farmaci)

                        DispatchQueue.main.async {
                            self.tablaFarmacia.reloadData()
                        }
//
                     }
                }
                
            }
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let alerta = UIAlertController(title: "Agregar", message: "Farmacia Nueva", preferredStyle: .alert)
        let acctionAcept = UIAlertAction(title: "Agregar", style: .default) { (_) in
            print("Se agrego el contacto correctamente")
            



            guard let identiAlert = alerta.textFields?.first?.text else {return}
            guard let telefonoAlert = Int64(alerta.textFields?[1].text ?? "00000000") else {return}
            guard let ciudadAlert = alerta.textFields?[2].text else {return}
            guard let estadoAlert = alerta.textFields?[3].text else {return}
            guard let direccionAlert = alerta.textFields?[4].text else {return}
            
            // Add a new document in collection "cities"
            
            self.db.collection("farmacia").document(identiAlert).setData([
                "Nombre": "Farmacias Leaf \(identiAlert)",
                "Estado": estadoAlert,
                "Ciudad": ciudadAlert,
                "Direccion": direccionAlert,
                "Telefono" : telefonoAlert
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
            print("NOMBRE \(identiAlert) , Telefono: \(telefonoAlert) , CIudad: \(ciudadAlert) , Edo: \(estadoAlert) , DIrec: \(direccionAlert)")
        }
        alerta.addTextField { (identiTxt) in
            identiTxt.placeholder = "Nombre"
            identiTxt.textColor = .blue
            identiTxt.textAlignment = .center
            identiTxt.autocapitalizationType = .words
        }
        alerta.addTextField { (telefonoTxt) in
            telefonoTxt.placeholder = "Telefono"
            telefonoTxt.keyboardType = .numberPad
            telefonoTxt.textColor = .blue
            telefonoTxt.textAlignment = .center
        }
        alerta.addTextField { (ciudadTxt) in
            ciudadTxt.placeholder = "Ciudad"
            ciudadTxt.textColor = .blue
            ciudadTxt.textAlignment = .center
        }
        alerta.addTextField { (edoTxt) in
            edoTxt.placeholder = "Estado"
            edoTxt.textColor = .blue
            edoTxt.textAlignment = .center
        }
        alerta.addTextField { (dirTxt) in
            dirTxt.placeholder = "Direccion"
            dirTxt.textColor = .blue
            dirTxt.textAlignment = .center
        }
        alerta.addAction(acctionAcept)
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(actionCancel)
        present(alerta, animated: true)
        
    }

}

extension FarmaciaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return farmacias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaFarmacia.dequeueReusableCell(withIdentifier: "FarmaCell", for: indexPath) as! TableViewCell

        celda.CiudadTxt.text = "\(farmacias[indexPath.row].Ciudad)  \(farmacias[indexPath.row].Estado)"
        celda.NombreTxt.text = farmacias[indexPath.row].Nombre
        celda.TelTxt.text = "\(farmacias[indexPath.row].Telefono)"
        return celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
        
    }
    
}
