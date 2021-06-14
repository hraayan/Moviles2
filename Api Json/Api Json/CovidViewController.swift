//
//  CovidViewController.swift
//  Api Json
//
//  Created by Mac2 on 23/05/21.
//

import UIKit

struct Covida: Codable {
    var country: String?
    var cases: String?
}
struct Covidsa: Codable {
    var covidCountries: [Covida]
}
class CovidViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var covidsa = [Covida]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(covidsa.count)
        return covidsa.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = CoviTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = covidsa[indexPath.row].country
        celda.detailTextLabel?.text = covidsa[indexPath.row].cases
        return celda
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        print(urlString)
        if let url = URL(string: urlString){
            if let datos = try? Data(contentsOf: url){
                print("datos: \(parsear(json: datos))")
                parsear(json: datos)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var CoviTable: UITableView!
    
    func parsear(json: Data){
        let decoder = JSONDecoder()
        if let jsonPeticiones = try? decoder.decode(Covidsa.self, from: json){
            
            print("Json Covid: \(jsonPeticiones.covidCountries.count)")
            covidsa = jsonPeticiones.covidCountries
            CoviTable.reloadData()
        }
    }

}
