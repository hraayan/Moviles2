//
//  MedicamentosViewController.swift
//  Farmacias
//
//  Created by Mac2 on 26/06/21.
//

import UIKit
import SafariServices
struct Medicina: Decodable {
    
    
    var resultados: [Resultados]
    
}
struct Resultados: Decodable {
    var nombre: String
    var labtitular: String
    var nregistro: String
    var vtm: Vtm
    let docs: [Docs]?
    var fotos: [Fotos]?
}

struct Vtm: Decodable {
    var nombre: String
}

struct Docs: Decodable {
    var tipo : Int?
    var url: URL?
    var urlHtml: String?
    
}

struct Fotos: Codable {
    var tipo: String
    var url: URL
}
struct Medicinas: Decodable {
    var result: [Resultados]
}

class MedicamentosViewController: UIViewController {

    @IBOutlet weak var medTable: UITableView!
    
    var medicinas = [Resultados]()
    //var datos:[Medicina] = []
    
    @IBAction func buscarBtn(_ sender: UIButton) {
        print("Buscar")
        if let busca = MedTxt.text {
            let urlString = "https://cima.aemps.es/cima/rest/medicamentos?nombre=\(busca)"
            print(urlString)
            if let url = URL(string: urlString){
                print(url)
                if let datos = try? Data(contentsOf: url){
                    //print("datos: \(datos.first)")
                    
                    parsear(json: datos)
                }
            }
        }
        
        
    }
    
    func parsear(json: Data){
        let decoder = JSONDecoder()
       
        print(json)
        print ("parsear")
        decoder.dateDecodingStrategy = .iso8601
        if let jsonPeticiones = try? decoder.decode(Medicina.self, from: json){
            print("se genero peticion")
            //print("JSON: \(jsonPeticiones.resultados[0].fotos?[0].url)")
            
            medicinas = jsonPeticiones.resultados
            if(medicinas.count == 0){
                let alerta = UIAlertController(title: "Oh No!", message: "No se encontraron resultados", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                
            }
//            for d in jsonPeticiones.result{
//
//                medicinas.append(d)
//
//            }
//            print("arreglo: \(medicinas.count)")
//            print("Json Covid: \(jsonPeticiones.result[0].resultados[0].nombre)")
//            medicinas = jsonPeticiones.result
            medTable.reloadData()
        }
        
        //let jsondata: Medicina = try! decoder.decode(Medicina.self, from: json)
        //print("JSON Cos: \(jsondata)")
        
    }
    @IBOutlet weak var MedTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "MedicaTableViewCell", bundle: nil)
        medTable.register(nib, forCellReuseIdentifier: "MedCell")
        
        navigationController?.navigationBar.barTintColor = view.backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
       
        
    }
    

}
extension MedicamentosViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(medicinas.count)
        return medicinas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = medTable.dequeueReusableCell(withIdentifier: "MedCell", for: indexPath) as! MedicaTableViewCell
        celda.nombreTxt?.text = medicinas[indexPath.row].nombre
        celda.LabTxt?.text = medicinas[indexPath.row].labtitular
        celda.actTxt?.text = medicinas[indexPath.row].vtm.nombre
        
       
        if let urlimg = medicinas[indexPath.row].fotos?[0].url{
            let data = try? Data(contentsOf: urlimg)
            DispatchQueue.main.async {
                if let imageData = data { let image = UIImage(data: imageData)
                    celda.img.image = image
                    
                    
                }
                
            }
            
            
        }
        
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        medTable.deselectRow(at: indexPath, animated: true)
        print(indexPath)
        if(medicinas[indexPath.row].docs != nil ){
            if(medicinas[indexPath.row].docs?.count != 0){
                if let urli = medicinas[indexPath.row].docs![0].urlHtml {
                    guard let urlpag = URL(string: urli)  else { return }
                    let vc = SFSafariViewController(url: urlpag)
                    present(vc, animated: true, completion: nil)
                    
                }else if let uurl = medicinas[indexPath.row].docs![0].url {
                    
                    let vc = SFSafariViewController(url: uurl)
                    present(vc, animated: true, completion: nil)
                    
                }
                else{
                    let alerta = UIAlertController(title: "Oh No!", message: "No se encontro la pgina web", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                    present(alerta, animated: true, completion: nil)
                    
                }
                
            }else{
                let alerta = UIAlertController(title: "Oh No!", message: "No se encontro la pgina web", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                
            }
        }else{
            let alerta = UIAlertController(title: "Oh No!", message: "No se encontro la pgina web", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
        
    }
    
}
