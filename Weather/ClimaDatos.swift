//
//  ClimaDatos.swift
//  Weather
//
//  Created by Mac2 on 28/04/21.
//

import Foundation
struct ClimaDatos: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Decodable{
    let temp : Double
    let feels_like: Double
    let humidity: Int
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
