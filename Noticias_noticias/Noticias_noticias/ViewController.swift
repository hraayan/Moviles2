//
//  ViewController.swift
//  Noticias_noticias
//
//  Created by Mac2 on 17/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    let defaultDB = UserDefaults.standard
    var posi: Int?
    var notas = ["Realizar practicas de PDM2"]
    var notaEdit: String?

    @IBOutlet weak var tabla: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //implementar cada que es tan;a
        
        tabla.delegate=self
        tabla.dataSource=self
        if let arrNotas = defaultDB.array(forKey: "notas") as? [String] {
            notas = arrNotas
        }
        print(defaultDB.array(forKey: "notas"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let arrNotas = defaultDB.array(forKey: "notas") as? [String] {
            notas = arrNotas
        }
        tabla.reloadData()
        print("se llamo el metodo willapear")
    }


    @IBAction func addNote(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Note", message: "New Note", preferredStyle: .alert)
        let accion = UIAlertAction(title: "Acept", style: .default) {(_) in
            print("Nota agregada")
            print(textField.text)
            self.notas.append(textField.text ?? "Valor vacio")
            print(self.notas)
            self.defaultDB.set(self.notas, forKey: "notas")
            self.tabla.reloadData()
        }
        
        let accionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(accion)
        alert.addAction(accionCancel)
        
        alert.addTextField { (textFieldAlerta) in
            textFieldAlerta.placeholder = "Add Note"
            textField =  textFieldAlerta
        }
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCelda = tabla.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        objCelda.textLabel?.text = notas[indexPath.row]
        let fecha = Date()
        let dateformat = DateFormatter()
        dateformat.dateStyle = .medium
        dateformat.timeStyle = .short
        objCelda.detailTextLabel?.text = "\(dateformat.string(from: fecha))"
        
        return objCelda
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seleccionaste el elemnto: \(indexPath.row)")
        posi = indexPath.row
        notaEdit = notas[indexPath.row]
        performSegue(withIdentifier: "editar", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar"{
            let objEditar = segue.destination as! EditViewController
            objEditar.reciveNote = notaEdit
            objEditar.arrNote = notas
            objEditar.posi = posi
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("eliminar objeto: \(notas[indexPath.row])")
            notas.remove(at: indexPath.row)
            //tabla.deleteRows(at: <#T##[IndexPath]#>, with: .fade)
            self.defaultDB.setValue(self.notas, forKey: "notas")
            tabla.reloadData()
            //eliminar de Db
            
        }
        
    }
    
    
    
}
