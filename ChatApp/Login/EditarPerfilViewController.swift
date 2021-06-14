//
//  EditarPerfilViewController.swift
//  Login
//
//  Created by marco rodriguez on 31/05/21.
//

import UIKit
import Firebase
import FirebaseStorage
class EditarPerfilViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nombreEditarTF: UITextField!
    @IBOutlet weak var imagenPerfil: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = Auth.auth().currentUser?.email{
            let defaults = UserDefaults.standard
            
            defaults.set(email, forKey: "email")
            defaults.synchronize()
            print("CUrrent User: \(Auth.auth().currentUser?.email)")
            print("en EditarUser  \(email)")
            
            if let index = email.firstIndex(of: "@"){
                let firstPath = email.prefix(upTo: index)
                nombreEditarTF.text = "\(firstPath)"
            }
        }
        
        let gestura = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        gestura.numberOfTapsRequired = 1
        gestura.numberOfTouchesRequired = 1
        imagenPerfil.addGestureRecognizer(gestura)
        imagenPerfil.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        DescargarImg()
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
    @IBAction func tomarFotoButton(_ sender: UIBarButtonItem) {
        print("Elegir foto o tomar 1")
    }
    
    @IBAction func GuardarPerfilButton(_ sender: UIButton) {
        
        print("Perfil Actualizado!")
        
        
        guard let image = imagenPerfil.image, let datosImagen = image.jpegData(compressionQuality: 1.0) else {
            print("error al subir")
            return  }
         let imageNombre = Auth.auth().currentUser?.email
       // let imageReferences = Firestore.firestore().collection("imagenes").document(imageNombre ?? "admin@mail.com")
        let imageReferences = Storage.storage().reference().child("imagenes").child(imageNombre ?? "admin@mail.com")
        
        imageReferences.putData(datosImagen, metadata: nil) { (metaData, error) in
                    if let err = error {
                        print("Error al subir imagen \(err.localizedDescription)")
                    }
            
                    imageReferences.downloadURL { (url, error) in
                        if let err = error {
                            print("Error al subir imagen \(err.localizedDescription)")
                            return
                        }
                        
                        guard let url = url else {
                            print("Error al crear url de la imagen")
                            return
                        }
                        
                        let dataReferencia = Firestore.firestore().collection("imagenes").document()
                        let documentoID = dataReferencia.documentID
                        
                        let urlString = url.absoluteString
                        
                        let datosEnviar = ["id": imageNombre,
                                    "url": urlString
                        ]
                        
                        dataReferencia.setData(datosEnviar) { (error) in
                            if let err = error {
                                print("Error al mandar datos de imagen \(err.localizedDescription)")
                                return
                            } else {
                                //Se subio a Firestore
                                print("Se guardó correctamente en FS")
                                //Ahora que harás cuando se guarde ?
                            }
                            
                            
                        }
                    }
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageSelect = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imagenPerfil.image = imageSelect
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func DescargarImg(){
        let email = Auth.auth().currentUser?.email
        let query = Firestore.firestore().collection("imagenes").whereField("id", isEqualTo: email)
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
                        self?.imagenPerfil.image = image
                        
                    }
                }
            }        }
        
    }
    
    
}


