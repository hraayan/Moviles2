//
//  FarmaciaViewController.swift
//  Farmacias
//
//  Created by Mac2 on 24/06/21.
//

import UIKit
import Firebase

class FarmaciaViewController: UIViewController {

    
    var farmacias = [1] //[Farmacia]()
    
    //Agregar la referencia a la BD Firestore
    //let db = Firestore.firestore()
    @IBOutlet weak var tablaFarmacia: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tablaFarmacia.register(nib, forCellReuseIdentifier: "FarmaCell")
        //ocultar el boton de regresar
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor =  view.backgroundColor
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        
        
    }
    
    @IBAction func addBtn(_ sender: Any) {
        print("ADD Farma")
    }

}

extension FarmaciaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaFarmacia.dequeueReusableCell(withIdentifier: "FarmaCell", for: indexPath) as! TableViewCell
        
//        let url = URL(string: "https://cima.aemps.es/cima/fotos/thumbnails/materialas/12680/12680_materialas.jpg")
//        let data = try? Data(contentsOf: url!)
//        if let imageData = data { let image = UIImage(data: imageData)
//            celda.img.image = image
//        }
        

        return celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
        
    }
    
}
