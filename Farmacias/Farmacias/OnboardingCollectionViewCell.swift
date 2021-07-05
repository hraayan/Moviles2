//
//  OnboardingCollectionViewCell.swift
//  Farmacias
//
//  Created by Mac2 on 04/07/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgDiapo: UIImageView!
    @IBOutlet weak var tituloTxt: UILabel!
    @IBOutlet weak var descTxt: UILabel!
    
    func configurar(diapositiva: OnboardingDiapositiva){
        imgDiapo.image = diapositiva.imagen
        tituloTxt.text = diapositiva.titulo
        descTxt.text = diapositiva.descripcion
    }
}

