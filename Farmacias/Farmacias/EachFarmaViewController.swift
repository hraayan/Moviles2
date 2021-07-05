//
//  EachFarmaViewController.swift
//  Farmacias
//
//  Created by Mac2 on 30/06/21.
//

import UIKit
import Firebase
import FirebaseFirestore
class EachFarmaViewController: UIViewController {

    var medica = [Medicamento]()
    var idRecive: String?
    var loct: String?
    var direcfarm: String?
    var telFarm: String?
    var ciudad: String?
    let db = Firestore.firestore()
    @IBOutlet weak var labl: UILabel!
    @IBOutlet weak var telTxt: UILabel!
    @IBOutlet weak var direccTxt: UILabel!
    @IBOutlet weak var locatTxt: UILabel!
    var direcSend: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = navigationController?.navigationBar.barTintColor
        // labl.text = "Famacia: \(idRecive!)"
        print("id: \(idRecive)")
        cargarFarmacia()
        // Do any additional setup after loading the view.
        cargarMedi()
        
        Collection.delegate = self
        Collection.dataSource = self
    }
    
    @IBAction func VerInfoBtn(_ sender: UIBarButtonItem) {
        cargarFarmacia()
        let alerta = UIAlertController(title: "INFORMACION DE FARMACIA", message: "\(idRecive!)\n \(direcfarm!)\n \(loct!)\n \(telFarm!)", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        self.present(alerta, animated: true, completion: nil)    }
    
    func cargarFarmacia()  {
        let docRef = db.collection("farmacia").document("\(idRecive!)")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                self.labl.text = "\(document.data()?["Nombre"] ?? "No Encontrado" )"
                self.loct = "\(document.data()?["Ciudad"] ?? "Ciudad")  \(document.data()?["Estado"] ?? "Estado" )"
                self.direcfarm = "\(document.data()?["Direccion"] ?? "No Encontrado" )"
                self.ciudad = "\(document.data()?["Ciudad"] ?? "No Encontrado" )"
                self.direcSend = "\(self.direcfarm!) \(self.ciudad!)"
                self.telFarm = "\(document.data()?["Telefono"] ?? "No Encontrado" )"
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    func cargarMedi(){
        db.collection("medicamentos").addSnapshotListener() { (querySnapshot, err) in
                //Vaciar arreglo de chats
                self.medica = []
                
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
                        guard let  nombre = datos["Direccion"] as? String else { return }
                        guard let  sal = datos["Sal"] as? String else { return }
                        guard let stock = datos["Stock"] as? Int else { return }
                        guard let farmacia = datos["farmacia"] as? String else { return }
                        guard let url = datos["urlimg"] as? String else { return }
                       
                        
                        let medi = Medicamento(Nombre: nombre, Sal: sal, Stock: stock, farmacia: farmacia, urlimg: url)

                        self.medica.append(medi)

//                        DispatchQueue.main.async {
//                            self.tablaFarmacia.reloadData()
//                        }
////
                     }
                }
                
            }
        }
        
    }
    
    @IBAction func gpsBtn(_ sender: UIBarButtonItem) {
       
        
    }
    
    @IBOutlet weak var Collection: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gps" {
            let objEdit = segue.destination as! GpsViewController
            objEdit.direcRecive = direcSend
            
        }
    }

}

extension EachFarmaViewController: UICollectionViewDelegate{
    
}

extension EachFarmaViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return med.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = Collection.dequeueReusableCell(withReuseIdentifier: "MedCollectionViewCell", for: indexPath) as! MedCollectionViewCell
        celda.configurar(med: med[indexPath.row])
        return celda
    }
    
    
}
