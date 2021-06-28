//
//  ProvesViewController.swift
//  Farmacias
//
//  Created by Mac2 on 25/06/21.
//

import UIKit

class ProvesViewController: UIViewController {

    @IBAction func addProve(_ sender: UIButton) {
    }
    
    @IBOutlet weak var tablaProves: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ProveTableViewCell", bundle: nil)
        tablaProves.register(nib, forCellReuseIdentifier: "ProveCell")
        navigationController?.navigationBar.barTintColor = view.backgroundColor
       
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = view.backgroundColor
       
        
    }


}

extension ProvesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaProves.dequeueReusableCell(withIdentifier: "ProveCell", for: indexPath) as! ProveTableViewCell
        
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        
    }
    
}
