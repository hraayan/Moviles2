//
//  NewsViewController.swift
//  Api Json
//
//  Created by Mac2 on 23/05/21.
//https://newsapi.org/v2/top-headlines?apiKey=5231410b7a1f4fcb8e4ac6d39285b50d&country=mx
import UIKit

struct Noticia: Codable {
    var title: String
    var description: String?
}
struct Noticias: Codable {
    var articles: [Noticia]
}
class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var noticias = [Noticia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=5231410b7a1f4fcb8e4ac6d39285b50d&country=mx"
        print(urlString)
        if let url = URL(string: urlString){
            if let datos = try? Data(contentsOf: url){
                print("datos: \(parsear(json: datos))")
                parsear(json: datos)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @IBOutlet weak var TNews: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TNews.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = noticias[indexPath.row].title
        celda.detailTextLabel?.text = noticias[indexPath.row].description
        return celda
        
    }
    
    func parsear(json: Data){
        let decoder = JSONDecoder()
        if let jsonPeticiones = try? decoder.decode(Noticias.self, from: json){
            print("Json News: \(jsonPeticiones.articles.count)")
            print("JSON: \(jsonPeticiones)")
            noticias = jsonPeticiones.articles
            print("news: \(noticias.count)")
            TNews.reloadData()
        }
    }

}
