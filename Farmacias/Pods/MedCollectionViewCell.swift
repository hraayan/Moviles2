//
//  MedCollectionViewCell.swift
//  Farmacias
//
//  Created by Mac2 on 04/07/21.
//

import UIKit

class MedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var Stocktxt: UILabel!
    @IBOutlet weak var salTxt: UILabel!
    @IBOutlet weak var nombreTxt: UILabel!
    @IBOutlet weak var imga: UIImageView!
    
    func configurar(med: Med){
        nombreTxt.text = med.Nombre
        salTxt.text = med.Sal
        Stocktxt.text = "\(med.Stock)"
        imga.image = med.imagen
    }
}
