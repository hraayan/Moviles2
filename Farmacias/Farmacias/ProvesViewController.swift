//
//  ProvesViewController.swift
//  Farmacias
//
//  Created by Mac2 on 25/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore
class ProvesViewController: UIViewController {

    var proves = [Proveedores]()
    var idSend: Int?
    
    //Agregar la referencia a la BD Firestore
    let db = Firestore.firestore()
    @IBAction func addProve(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Agregar Proveedor", message: "Registra la informacion general, podras agregar mas datos al ingresar al proveedor", preferredStyle: .alert)
        let acctionAcept = UIAlertAction(title: "Agregar", style: .default) { (_) in
            print("Se agrego el contacto correctamente")
          
            guard let nombreAlert = alerta.textFields?.first?.text else {return}
            guard let telefonoAlert = alerta.textFields?[1].text  else {return}
            guard let ciudadAlert = alerta.textFields?[2].text else {return}
            guard let estadoAlert = alerta.textFields?[3].text else {return}
            guard let direccionAlert = alerta.textFields?[4].text else {return}
            let newId = self.proves.count + 1
            // Add a new document in collection "cities"
            
            self.db.collection("proveedores").document("\(newId)").setData([
                "Nombre": nombreAlert ,
                "Estado": estadoAlert,
                "Ciudad": ciudadAlert,
                "Direccion": direccionAlert,
                "Telefono" : telefonoAlert,
                "CP": "Sin Capturar",
                "RFC" : "Sn Capturar",
                "Correo" : "Sin Capturar",
                "Linea" :"Sin Capturar",
                "urlimg": "https://incresc.com/images/incresc/fondo_sin_imagen_perfil_usuario.png"
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
           
        }
        alerta.addTextField { (nombreTxt) in
            nombreTxt.placeholder = "Nombre"
            nombreTxt.textColor = .blue
            nombreTxt.textAlignment = .center
            nombreTxt.autocapitalizationType = .words
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
            ciudadTxt.autocapitalizationType = .words
            
        }
        alerta.addTextField { (edoTxt) in
            edoTxt.placeholder = "Estado"
            edoTxt.textColor = .blue
            edoTxt.textAlignment = .center
            edoTxt.autocapitalizationType = .words
            
        }
        alerta.addTextField { (dirTxt) in
            dirTxt.placeholder = "Direccion"
            dirTxt.textColor = .blue
            dirTxt.textAlignment = .center
            dirTxt.autocapitalizationType = .words
            
        }
        alerta.addAction(acctionAcept)
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(actionCancel)
        present(alerta, animated: true)
        
    
        tablaProves.reloadData()
    }
    
    @IBOutlet weak var tablaProves: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ProveTableViewCell", bundle: nil)
        tablaProves.register(nib, forCellReuseIdentifier: "ProveCell")
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        cargarProvedor()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
       cargarProvedor()
        
    }
    
    func cargarProvedor(){
        db.collection("proveedores").addSnapshotListener() { (querySnapshot, err) in
            //Vaciar arreglo de chats
            self.proves = []
            
            if let e = err {
                print("Error al obtener los chats: \(e.localizedDescription)")
            } else {
                if let snapshotDocumentos = querySnapshot?.documents {
                    for document in snapshotDocumentos {
                        //crear mi objeto mensaje
                        let datos = document.data()
                        print("ID \(document.documentID)")
                        let idInt = Int(document.documentID)
                        print("id Int: \(idInt!)")
                        print(datos)
                        //Sacar los parametros p obj Mensaje
                        guard let  idp = idInt  else { return }
                        guard let  direc = datos["Direccion"] as? String  else { return }
                        //print(direc)
                        guard let ciudad = datos["Ciudad"] as? String else { return }
                        //print(ciudad)
                        guard let estado = datos["Estado"] as? String else { return }
                        //print(estado)
                        guard let telefono = datos["Telefono"] as? String else { return }
                        //print(telefono)
                        guard let nombre = datos["Nombre"] as? String else { print("No sse encontro")
                            return }
                        //print(nombre)
                        guard let correo = datos["Correo"] as? String else {print("No sse encontro")
                            return }
                        //print(correo)
                        guard let rfc = datos["RFC"] as? String else {print("No sse encontro")
                            return }
                        //print(rfc)
                        guard let cp = datos["CP"] as? String else {print("No sse encontro")
                            return }
                        //print(cp)
                        guard let linea = datos["Linea"] as? String else { print("No sse encontro")
                            return }
                        //print(linea)
                        guard let img = datos["urlimg"] as? String else { print("No sse encontro")
                            return }
                            let prov = Proveedores(id:idp , Nombre: nombre, RFC: rfc, Telefono: telefono, Direccion: direc, Ciudad: ciudad, Estado: estado, CP: cp, Correo: correo, Linea: linea, UrlImg: img)
                        
                        self.proves.append(prov)
                        DispatchQueue.main.async {
                            self.tablaProves.reloadData()
                            
                            
                        }
                        
                    }
                    
                }
                
            }
        }
    }
    
    

}

extension ProvesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count id: \(proves.count + 1)")
        return proves.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaProves.dequeueReusableCell(withIdentifier: "ProveCell", for: indexPath) as! ProveTableViewCell
        
        celda.nombreTxt.text = proves[indexPath.row].Nombre
        celda.correoTxt.text = "📧 \(proves[indexPath.row].Correo)"
        celda.telTxt.text = "☎️ \(proves[indexPath.row].Telefono)"
        celda.proveidoTxt.text = proves[indexPath.row].Linea
        if let urlimg = proves[indexPath.row].UrlImg{
            let url = URL(string: urlimg)
            let imgalr = URL(string:"https://incresc.com/images/incresc/fondo_sin_imagen_perfil_usuario.png")
            let data = try? Data(contentsOf: url ?? imgalr!)
            
            DispatchQueue.main.async {
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    celda.img.image = image
                    
                }
            }
        }
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablaProves.deselectRow(at: indexPath, animated: true)
        
        idSend = proves[indexPath.row].id
        performSegue(withIdentifier: "ViewProv", sender: self)
        print("idSend: \(idSend)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewProv" {
            let objEdit = segue.destination as! ProveedorViewController
            objEdit.idRecive = idSend
            
        }
    }
}
