//
//  MedCell.swift
//  Farmacias
//
//  Created by Mac2 on 04/07/21.
//

import UIKit

struct Med {
    let Nombre: String
    let Sal: String
    let Stock: Int
    let imagen: UIImage
}

let med: [Med] = [
    Med(Nombre: "Aspirina 400mg", Sal: "Acido acetil salicilico", Stock: 20, imagen: #imageLiteral(resourceName: "Aspirina 40s_Izquierdo_Alta")),
    Med(Nombre: "Tempra 400mg", Sal: "Paracetamol", Stock: 80, imagen: #imageLiteral(resourceName: "694-6945463_pastillas-tempra-caja-de-500mg-paracetamol")),
    Med(Nombre: "Convibent Respimat", Sal: "Bromuro de Itratopio", Stock: 10, imagen: #imageLiteral(resourceName: "32326")),
    Med(Nombre: "Forxiga 400mg", Sal: "acido acervico", Stock: 2, imagen: #imageLiteral(resourceName: "797-0171960_05")),
    Med(Nombre: "Omeprazol 500ms", Sal: "esomeprazol", Stock: 150, imagen: #imageLiteral(resourceName: "7502223704909")),
]
