//
//  InicioViewController.swift
//  Login
//
//  Created by marco rodriguez on 26/05/21.
//

import UIKit
import Firebase

class InicioViewController: UIViewController {
    
    var chats = [Mensaje]()
    
    //Agregar la referencia a la BD Firestore
    let db = Firestore.firestore()
    

    @IBOutlet weak var mensajeEnviarTF: UITextField!
    @IBOutlet weak var tablaChats: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        tablaChats.register(nib, forCellReuseIdentifier: "MjsCell")
        
        //ocultar el boton de regresar
        navigationItem.hidesBackButton = true
        
        cargarMensajes()
        
        
        if let email = Auth.auth().currentUser?.email{
            let defaults = UserDefaults.standard
            
            defaults.set(email, forKey: "email")
            defaults.synchronize()
            print("CUrrent User: \(Auth.auth().currentUser?.email)")
            print("en User defaults: \(defaults)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cargarMensajes()
    }
    func cargarMensajes(){
        db.collection("mensajes")
            .order(by: "fechaCreacion")
            .addSnapshotListener() { (querySnapshot, err) in
                //Vaciar arreglo de chats
                self.chats = []
                
            if let e = err {
                print("Error al obtener los chats: \(e.localizedDescription)")
            } else {
                if let snapshotDocumentos = querySnapshot?.documents {
                    for document in snapshotDocumentos {
                        //crear mi objeto mensaje
                        let datos = document.data()
                        print(datos)
                        // Sacar los parametros p obj Mensaje
                        guard let remitenteFS = datos["remitente"] as? String else { return }
                        guard let mensajeFS = datos["mensaje"] as? String else { return }
                        
                        let nuevoMensaje = Mensaje(remitente: remitenteFS, cuerpoMsj: mensajeFS)
                        
                        self.chats.append(nuevoMensaje)
                        
                        DispatchQueue.main.async {
                            self.tablaChats.reloadData()
                        }
                       
                     }
                }
                
            }
        }
        
        
    }
    
    
    
    @IBAction func enviarButton(_ sender: UIButton) {
        if let mensaje = mensajeEnviarTF.text, let remitente = Auth.auth().currentUser?.email {
            db.collection("mensajes").addDocument(data: [
                "remitente": remitente,
                "mensaje": mensaje,
                "fechaCreacion": Date().timeIntervalSince1970
            ]) { (error) in
                //si hubo errro
                if let e = error {
                    print("Error al guardar en Firestore \(e.localizedDescription)")
                } else {
                    //Se realizo la insersion a firestore
                    print("Se guardo la info en firestore")
                    self.mensajeEnviarTF.text = ""
                }
            }
        }
    }
    
    
    
    @IBAction func salirButton(_ sender: UIBarButtonItem) {
        
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
    
    

}

//MARK: - Uitable View Methods
extension InicioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaChats.dequeueReusableCell(withIdentifier: "MjsCell", for: indexPath) as! ChatTableViewCell
        
        
        var nombre = chats[indexPath.row].remitente
        if let index = nombre.firstIndex(of: "@"){
            let firstPath = nombre.prefix(upTo: index)
            celda.DestinatLabel.text = "\(firstPath)"
            
        }
        //celda.MensajeTxt.text =
        celda.MensajeTxt.text = chats[indexPath.row].cuerpoMsj
        
        func DescargarImg(){
            let email = Auth.auth().currentUser?.email
            let query = Firestore.firestore().collection("imagenes").whereField("id", isEqualTo: nombre)
            query.getDocuments { (snapshot,error) in
                if let err = error {
                    print("Error al descargar imagen: \(err.localizedDescription)")
                }
                guard let snapshot = snapshot,
                      let data = snapshot.documents.first?.data(),
                      let urlString = data["url"] as? String,
                      let url = URL(string: urlString)
                else { return }
                
                
                DispatchQueue.main.async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            celda.imageContact.image = image
                            
                        }
                    }
                }        }
            
        }
        DescargarImg()
        return celda
    }
    
    
}
