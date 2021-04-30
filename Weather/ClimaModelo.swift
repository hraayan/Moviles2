//
//  ClimaModelo.swift
//  Weather
//
//  Created by Mac2 on 29/04/21.
//

import Foundation

struct ClimaModelo {
    let temp: Double
    let nombreCiudad: String
    let id: Int
    let feels_like: Double
    let humidity: Int
    
    var temString: String{
        return String(format: "%1.f", temp)
    }
    var feels_likeString: String{
        return String(format: "%1.f", feels_like)
        
    }
    var humidityString: String{
        return String(format: "\(humidity)", humidity)
    }
    
    var condicionClima: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.hail"
        case 500...531:
            return "cloud.sleet"
        case 600...622:
            return "snow"
        case 701...781:
            return "sun.dust"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun"
            
        default:
            return "sun"
        }
        
    }
    
    
}



