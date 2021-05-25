//
//  CovidsViewController.swift
//  Api Json
//
//  Created by Mac2 on 23/05/21.
//

import UIKit

struct Covid: Codable {
    
    var country: String
    var cases: Int
    
    
}


struct Covids: Codable {
    var covids: [Covid]
}
class CovidsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var CoviTable: UITableView!
    var covids = [Covid]()
    var datos:[Covid] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(covids.count)
        return covids.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = CoviTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = "PAIS: \(covids[indexPath.row].country)"
        celda.detailTextLabel?.text = "Casos: \(covids[indexPath.row].cases)"
        return celda
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        print(urlString)
        if let url = URL(string: urlString){
            if let datos = try? Data(contentsOf: url){
                print("datos: \(datos)")
                
                parsear(json: datos)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    
    
    func parsear(json: Data){
        let decoder = JSONDecoder()
        print(json.count)
        
        if let jsonPeticiones = try? decoder.decode([Covid].self, from: json){
            
            print("JSON: \(jsonPeticiones)")
            for d in jsonPeticiones{
                
                covids.append(d)
                
            }
            print("arreglo: \(covids)")
            //print("Json Covid: \(jsonPeticiones[0])")
          //  covids = jsonPeticiones.result
            CoviTable.reloadData()
        }
        
        //let jsondata: Covid = try! decoder.decode(Covid.self, from: json)
        //print("JSON Cos: \(jsondata)")
        
    }

}

