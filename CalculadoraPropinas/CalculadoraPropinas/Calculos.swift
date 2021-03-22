//
//  Calculos.swift
//  CalculadoraPropinas
//
//  Created by Mac2 on 21/03/21.
//

import Foundation

struct Calculos {
    var propina: propinas?
    
    mutating func calculaPropina(tcuenta: Float, porcentaje: Float, personas: Int){
        let tpropina = (tcuenta * porcentaje) / 100
        print(("total propina"), tpropina)
        print("total personas", personas)
        let propinaPersona = (tpropina / Float (personas))
        print(propinaPersona)
        propina = propinas(tpropina: tpropina, tpersona: propinaPersona)
    }
    
    func retornaPropina() -> String{
        let tpropina =  String(format: "%.1f", propina?.tpropina ??  0.0)
        return tpropina
    }
    func retornaCuenta() -> String{
        let tpersona = String(format: "%.1f", propina?.tpersona ?? 0.0)
        return tpersona
    }
   
}


