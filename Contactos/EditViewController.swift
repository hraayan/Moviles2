//
//  EditViewController.swift
//  Contactos
//
//  Created by Mac2 on 21/05/21.
//

import UIKit

class EditViewController: UIViewController {

    var reciveNombre: String?
    var reciveTelefono: String?
    var reciveCorreo: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombreTxt.text = reciveNombre
        let gestura = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        gestura.numberOfTapsRequired = 1
        gestura.numberOfTouchesRequired = 1
        ImageContact.addGestureRecognizer(gestura)
        ImageContact.isUserInteractionEnabled = true
    }
    
    @objc func clickImage(gestura: UITapGestureRecognizer){
        print("Cambia imagen")
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func FotoBtn(_ sender: UIBarButtonItem) {
        
    }
    
    @IBOutlet weak var ImageContact: UIImageView!
    @IBOutlet weak var nombreTxt: UITextField!
    
    @IBAction func CorreoTxt(_ sender: UITextField) {
    }
    @IBAction func TelefonoTxt(_ sender: UITextField) {
    }
    @IBAction func SaveBtn(_ sender: UIButton) {
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
