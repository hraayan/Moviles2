//
//  EditViewController.swift
//  Contactos
//
//  Created by Mac2 on 21/05/21.
//

import UIKit
import CoreData
class EditViewController: UIViewController {

    var reciveNombre: String?
    var reciveTelefono: Int64?
    var reciveCorreo: String?
    var reciveIndice: Int?
    @IBOutlet weak var ImageContact: UIImageView!
    var contactos = [Contactos]()
    //conexion
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarCoreData()
        print("indice: \(reciveIndice!)")
        ImageContact.image = UIImage(data: contactos[reciveIndice!].imagen!)
        nombreTxt.text = reciveNombre
        TelefonoTxt.text = "\(reciveTelefono ?? 0000)"
        print("telefono: \(reciveTelefono)")
        CorreoTxt.text = reciveCorreo
        let gestura = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        gestura.numberOfTapsRequired = 1
        gestura.numberOfTouchesRequired = 1
        ImageContact.addGestureRecognizer(gestura)
        ImageContact.isUserInteractionEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func clickImage(gestura: UITapGestureRecognizer){
        print("Cambia imagen")
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func cargarCoreData() {
        let fetchRequest : NSFetchRequest<Contactos> = Contactos.fetchRequest()
        do {
            contactos = try contexto.fetch(fetchRequest)
        } catch  {
            print("Error al cargar DB")
        }
    }
    
    @IBAction func FotoBtn(_ sender: UIBarButtonItem) {
        
    }
    
   
    @IBOutlet weak var nombreTxt: UITextField!
    
    @IBOutlet weak var CorreoTxt: UITextField!
    
    
    @IBOutlet weak var TelefonoTxt: UITextField!
    @IBAction func SaveBtn(_ sender: UIButton) {
        
        do {
            contactos[reciveIndice!].setValue(nombreTxt.text, forKey: "nombre")
            contactos[reciveIndice!].setValue(Int64(TelefonoTxt.text ?? "0000"), forKey: "telefono")
            print("telefono guardar : \(TelefonoTxt.text)")
            contactos[reciveIndice!].setValue(CorreoTxt.text, forKey: "correo")
            contactos[reciveIndice!].setValue(ImageContact.image?.pngData(), forKey: "imagen")
            try self.contexto.save()
            navigationController?.popViewController(animated: true)
            print("Se actualizo contexto")
        } catch  {
            print("erro al actualizar")
        }
    }
    @IBAction func Cancelbtn(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}
 // protocol de gestura de selec imagen
extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelect = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            ImageContact.image = imageSelect
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
