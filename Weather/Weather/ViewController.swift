//
//  ViewController.swift
//  Weather
//
//  Created by Mac2 on 27/04/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegado, CLLocationManagerDelegate {
    
    var latitud: CLLocationDegrees?
    var longitud: CLLocationDegrees?
    func huboError(erro: Error) {
        print(erro.localizedDescription)
        DispatchQueue.main.async {
            let alerta = UIAlertController(title: "Error", message: "Lugar no encontrado", preferredStyle: .alert)
            let accionOk = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alerta.addAction(accionOk)
            self.present(alerta, animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBOutlet weak var humeLabel: UILabel!
    var climaManager = ClimaManager()
    //para obtener la ubicacion del dispositivo
    var climaLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BuscarTxt.delegate = self
        //clase como delegado
        climaManager.delegado = self
        climaLocationManager.delegate = self
        climaLocationManager.requestWhenInUseAuthorization()
        climaLocationManager.requestLocation()
    }

    @IBOutlet weak var BuscarTxt: UITextField!
    @IBOutlet weak var CondicionImage: UIImageView!
    @IBAction func BuscarAct(_ sender: UIButton) {
        print(BuscarTxt.text)
        BuscarTxt.endEditing(true)
        if BuscarTxt.text != ""{
            CiudadLabel.text = BuscarTxt.text        }
        
    }
    // metodos del delegado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(BuscarTxt.text!)
        CiudadLabel.text = BuscarTxt.text
        BuscarTxt.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if BuscarTxt.text != ""{
            return true
        }else{
            BuscarTxt.placeholder = "Escribe algo"
            return false
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        climaManager.buscaClima(ciudad: BuscarTxt.text!)
        CiudadLabel.text = BuscarTxt.text
        BuscarTxt.text = ""
    }
    func actualizarClima(clima: ClimaModelo) {
        DispatchQueue.main.async {
            print(clima.temString)
            self.TempLabel.text = clima.temString
            self.CiudadLabel.text = clima.nombreCiudad
            self.CondicionImage.image = UIImage(systemName: clima.condicionClima)
            self.feelLikeLabel.text = clima.feels_likeString
            self.humeLabel.text = clima.humidityString
        }
        
        
    }
    
    //MARK:- Metodos de ubicacion
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let ubicacion = locations.last {
            let latitud = ubicacion.coordinate.latitude
            let longitud = ubicacion.coordinate.longitude
            self.latitud = latitud
            self.longitud = longitud
            print("Se obtuvo la ub, lat: \(latitud)& longitud \(longitud)")
            climaManager.buscarGps(lat: latitud, lon: longitud)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error al obtener ubicacion")
    }
    
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBAction func LocatAct(_ sender: UIButton) {
        climaManager.buscarGps(lat: latitud!, lon: longitud!)
    }
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var CiudadLabel: UILabel!
}

