//
//  GpsViewController.swift
//  Farmacias
//
//  Created by Mac2 on 04/07/21.
//

import UIKit
import CoreLocation
import MapKit
class GpsViewController: UIViewController, MKMapViewDelegate{
    var manager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    var altitud: Double?
    var direcRecive: String?
    @IBOutlet weak var mapa: MKMapView!
   
    @IBOutlet weak var buscador: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(direcRecive)
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        manager.startUpdatingLocation()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        buscador.delegate = self
        mapa.delegate = self
        //buscador.text = direcRecive
    }
    

   

}

extension GpsViewController: CLLocationManagerDelegate, UISearchBarDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Numero de ubicaciones: \(locations.count)")
        guard let ubicacion = locations.first else{
            return
        }
        lat = ubicacion.coordinate.latitude
        lon = ubicacion.coordinate.longitude
        altitud = ubicacion.altitude
        print("lat: \(lat)")
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener ubicacion \(error.localizedDescription)")
        
        //crear alerta de error lugar no encontrado
        let alert = UIAlertController(title: "Error Lugar No Encontrado", message: "No pudimos encontrar el lugar deseado :(", preferredStyle: .alert)
        let accion = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(accion)
        self.present(alert, animated: true)
           }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        buscador.resignFirstResponder()
        let geocoder = CLGeocoder()
        if let direccion = buscador.text {
            geocoder.geocodeAddressString(direccion) { (places: [CLPlacemark]?, error: Error?) in
                
                //crear el destino
                guard let destinoRuta = places?.first?.location else{return}
                
                if error == nil{
                    let lugar = places?.first
                    let anotation = MKPointAnnotation()
                    anotation.coordinate = (lugar?.location?.coordinate)!
                    anotation.title = direccion
                    let origen = CLLocation(latitude: self.lat!, longitude: self.lon!)
                    let distancia = origen.distance(from: destinoRuta)
                    print("la distancia es \(distancia/1000)")
                    let distancKm = String(format: "%.2f", distancia/1000)
                    let alert = UIAlertController(title: "Distancia", message: "\(self.buscador.text ?? "el destino ") se encuentra a: \(distancKm) km", preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                    alert.addAction(accion)
                    self.present(alert, animated: true)
                    
                    let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
                    let region = MKCoordinateRegion(center: anotation.coordinate, span: span)
                    self.mapa.setRegion(region, animated: true)
                    self.mapa.addAnnotation(anotation)
                    self.mapa.selectAnnotation(anotation, animated: true)
                    
                    
                    
                    // llama traza ruta
                    //self.trazarRuta(coordDestino: destinoRuta.coordinate)
                    
                }else{
                    print("Error al encontrar direccion \(error?.localizedDescription)")
                    
                }
            }
        }
    }
}
