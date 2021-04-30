//
//  ClimaManager.swift
//  Weather
//
//  Created by Mac2 on 28/04/21.
//

import Foundation

protocol ClimaManagerDelegado {
    func actualizarClima(clima: ClimaModelo)
    func huboError(erro: Error)}

struct ClimaManager {
    let climaUrl = "https://api.openweathermap.org/data/2.5/weather?appid=3efd5319aab98e25bb610f1d264a3a5a&units=metric&lang=es"
    
    var delegado: ClimaManagerDelegado?
    
    func buscaClima(ciudad: String){
        print("Ciudad: \(ciudad)")
        let urlString = "\(climaUrl)&q=\(ciudad)"
        print("URL: \(urlString)")
        realizaSolicitud(urlString: urlString)
    }
    func buscarGps(lat: Double, lon: Double){
        let urlString = "\(climaUrl)&lat=\(lat)&lon=\(lon)"
        realizaSolicitud(urlString: urlString)
    }
    
    
    func realizaSolicitud(urlString: String){
        if let url = URL(string: urlString){
            //crear url sesion
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) { (datos, respuesta, error) in
                if error != nil{
                    self.delegado?.huboError(erro: error!)
                    
                    return
                }
                if let datosSeguros = datos {
                    //parsear json
                    if let objClima = self.parsearJson(datosClima: datosSeguros){
                        // mandar objeto a VC
                        //let Climavc=ViewController()
                        //Climavc.actualizarClima(objclima: objClima)
                        
                        //delegado
                        self.delegado?.actualizarClima(clima:objClima)
                    }
                }
                
                
            }
            tarea.resume()
            
        }
        
    }
    
    func parsearJson(datosClima: Data) -> ClimaModelo?{
        //decoder json
        let decodificador = JSONDecoder()
        do {
            
            let datosDecodificados = try decodificador.decode(ClimaDatos.self, from: datosClima)
            print("Cidad buscada: \(datosDecodificados.name)")
            print("Temperatura: \(datosDecodificados.main.temp)")
            print("Temperatura: \(datosDecodificados.main.feels_like)")
            let id = datosDecodificados.weather[0].id
            let ciudad = datosDecodificados.name
            let temp = datosDecodificados.main.temp
            let feels_like = datosDecodificados.main.feels_like
            let humidity = datosDecodificados.main.humidity
            let objClima = ClimaModelo(temp: temp, nombreCiudad: ciudad, id: id, feels_like: feels_like, humidity: humidity)
            //objClima.obtenerCondicionClima(idClima: id)
            print(objClima.condicionClima)
            print(objClima.temString)
            
            return objClima
        } catch  {
            delegado?.huboError(erro: error)
            return nil
        }
        
    }
    
    
}
