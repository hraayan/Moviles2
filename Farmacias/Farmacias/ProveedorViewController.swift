//
//  ProveedorViewController.swift
//  Farmacias
//
//  Created by Mac2 on 01/07/21.
//

import UIKit

class ProveedorViewController: UIViewController {

    @IBOutlet weak var labl: UILabel!
    var idRecive: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        labl.text = "Proveedor num: \(idRecive!)"
    }
    

   
}
