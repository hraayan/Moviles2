//
//  ViewController.swift
//  Wiki
//
//  Created by Mac2 on 11/05/21.
//

import UIKit
import WebKit
class ViewController: UIViewController {
    @IBOutlet weak var Webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //
        if let imgUrl = URL(string: "https://windup.es/wp-content/uploads/2020/01/que-es-google-search-console-01.png"){
            print(imgUrl)
            Webview.load(URLRequest(url: imgUrl))
        }
        
    }


    
    
    
    @IBOutlet weak var BuscarTxt: UITextField!
    @IBAction func SearchButt(_ sender: UIButton) {
        guard let palabraAbus = BuscarTxt.text else { return }
        buscarWiki(palabras: palabraAbus)
    }
    func buscarWiki(palabras:String){
        if let urlApi = URL(string: "https://es.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&titles=\(palabras.replacingOccurrences(of: " " , with: "%20"))"){
            let peticion = URLRequest(url: urlApi)
            let tarea = URLSession.shared.dataTask(with: peticion){
                (datos, respuesta, err) in
                if err != nil{
                    print(err?.localizedDescription)
                }else{
                    do {
                        let objson = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        let querySubJson = objson["query"] as! [String: Any]
                        let pagesSubJson = querySubJson["pages"] as! [String: Any]
                        let pageId = pagesSubJson.keys
                        let keyExtract = pageId.first!
                        
                        print("Id: \(keyExtract)")
                        let idSubJson = pagesSubJson[keyExtract] as! [String: Any]
                        let extracto = idSubJson["extract"] as? String
                            
                        
                        
                        //mandar al web view
                        DispatchQueue.main.async {
                            self.Webview.loadHTMLString(extracto ?? "<h1>No se obtuvo ningun resultado</h1>", baseURL: nil)
                            
                        }
                        
                        
                        print("La subconsulta es \(querySubJson)")
                        print("El obj Json es: \(objson)")
                    } catch  {
                        print("Error al procesar JSOn \(err?.localizedDescription)")
                        
                    }
                }
            }
            tarea.resume()
            
        }
    }
}

