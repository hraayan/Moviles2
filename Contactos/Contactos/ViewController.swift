//
//  ViewController.swift
//  Contactos
//
//  Created by Mac2 on 20/05/21.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    var contactos = [Contactos]()
    //conexion
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var nombreSend: String?
    var telefonoSend: Int64?
    var correoSend: String?
    var indiceSend: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cargarCoreData()
        TContacts.reloadData()
        TContacts.delegate = self
        TContacts.dataSource = self
        TContacts.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        TContacts.reloadData()
    }

    @IBOutlet weak var TContacts: UITableView!
    
    @IBAction func newContact(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title: "Agregar", message: "Nuevo Contacto", preferredStyle: .alert)
        let acctionAcept = UIAlertAction(title: "Agregar", style: .default) { (_) in
            print("Se agrego el contacto correctamente")
            //obj paa guardar en Coredata
            
            
            
            guard let nombreAlert = alerta.textFields?.first?.text else {return}
            guard let telefonoAlert = Int64(alerta.textFields?[1].text ?? "00000000") else {return}
            guard let correoAlert = alerta.textFields?.last?.text else {return}
            let imageTemporal = UIImageView(image: #imageLiteral(resourceName: "6e5132a90812ad1abf3711135a5cf406"))
            //let newContact = MiContacto(nombre: nombreAlert, telefono: telefonoAlert, correo: correoAlert)
            let newContact = Contactos(context: self.contexto)
            newContact.nombre = nombreAlert
            newContact.telefono = telefonoAlert
            newContact.correo = correoAlert
            newContact.imagen = imageTemporal.image!.pngData()
            
            self.contactos.append(newContact)
            self.guardarContact()
            self.TContacts.reloadData()
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
        alerta.addTextField { (correoTxt) in
            correoTxt.placeholder = "Correo"
            correoTxt.textColor = .blue
            correoTxt.textAlignment = .center
        }
        
        alerta.addAction(acctionAcept)
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(actionCancel)
        present(alerta, animated: true)
    }
    
    func guardarContact() {
        do {
            try contexto.save()
            print("Se guardo correctamente")
        } catch let error as NSError {
            print("Error al guardar: \(error.localizedDescription)")
        }
    }
    
    func cargarCoreData() {
        let fetchRequest : NSFetchRequest<Contactos> = Contactos.fetchRequest()
        do {
            contactos = try contexto.fetch(fetchRequest)
        } catch  {
            print("Error al cargar DB")
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celd = TContacts.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! PersonTableViewCell
        celd.Nombre.text = contactos[indexPath.row].nombre
        celd.TelefonoL.text = "📲 \(contactos[indexPath.row].telefono ?? 000000)"
        celd.CorreoL.text = "📧 \(contactos[indexPath.row].correo ?? "sin correo")"
        celd.imgVie.image = UIImage(data: contactos[indexPath.row].imagen!)
        return celd
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TContacts.deselectRow(at: indexPath, animated: true)
        nombreSend = contactos[indexPath.row].nombre
        telefonoSend = contactos[indexPath.row].telefono
        correoSend = contactos[indexPath.row].correo
        indiceSend = indexPath.row
        print("indice \(indexPath.row)")
        performSegue(withIdentifier: "editContact", sender: self)
    }
    
    //Swips
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionDelete = UIContextualAction(style: .normal, title: "") { (_,_,_) in
            
            print("Borrer")
            //eliminar
            self.contexto.delete(self.contactos[indexPath.row])  //coredata
            self.contactos.remove(at: indexPath.row)
            self.guardarContact()
            self.TContacts.reloadData()
        }
        accionDelete.image = UIImage(named: "borrar.png")
        accionDelete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [accionDelete])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionCorreo = UIContextualAction(style: .normal, title: "") { (_, _, _) in
            print("correo")
        }
        accionCorreo.image = UIImage(named: "correo.png")
        accionCorreo.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [accionCorreo])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            let objEdit = segue.destination as! EditViewController
            objEdit.reciveNombre = nombreSend
            objEdit.reciveTelefono = telefonoSend
            objEdit.reciveCorreo = correoSend
            objEdit.reciveIndice = indiceSend
        }
    }
    
}

