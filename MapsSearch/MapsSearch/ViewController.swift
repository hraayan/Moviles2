//
//  ViewController.swift
//  MapsSearch
//
//  Created by Mac2 on 05/05/21.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController, MKMapViewDelegate {
    var manager = CLLocationManager()
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    var altitud: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        manager.startUpdatingLocation()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        buscador.delegate = self
        mapa.delegate = self
    }
    
    
    //MARK:- trazar la ruta
    
    func trazarRuta(coordDestino: CLLocationCoordinate2D){
        guard let coordOrigen = manager.location?.coordinate else{
            return
        }
        
        
        //crear lugra de origen destino
        let origenPlaceMark = MKPlacemark(coordinate: coordOrigen)
        let destinoPlaceMark = MKPlacemark(coordinate: coordDestino)
        // obj mapkit item
        let origenItem = MKMapItem(placemark: origenPlaceMark)
        let destinoItem = MKMapItem(placemark: destinoPlaceMark)
        
        // solicitud de ruta
        let solicitudDestino = MKDirections.Request()
        solicitudDestino.source = origenItem
        solicitudDestino.destination = destinoItem
        
        //como se va a viajar, caminando coche
        solicitudDestino.transportType = .automobile
        solicitudDestino.requestsAlternateRoutes = true
        
        let direcciones = MKDirections(request: solicitudDestino)
        direcciones.calculate { (respuesta, error) in
            guard let respuestaSegura = respuesta else{
                if let error = error {
                    print("Error al calcular la rura \(error.localizedDescription)")
                    
                    let alert = UIAlertController(title: "Error al calcular la ruta",message: "", preferredStyle: .alert)
                    let accion = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                    alert.addAction(accion)
                    self.present(alert, animated: true)                }
                return
            }
            
            // si todo salio bien
            print(respuestaSegura.routes.count)
            let ruta = respuestaSegura.routes[0]
            // agregar marka al mapa superposicion
            self.mapa.addOverlay(ruta.polyline)
            self.mapa.setVisibleMapRect(ruta.polyline.boundingMapRect, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderiz = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderiz.strokeColor = .blue
        return renderiz
    }
    

    @IBAction func ubicatButt(_ sender: UIBarButtonItem) {
        
        guard let alt = altitud else{
            return
        }
        
        let alert = UIAlertController(title: "Ubicacion", message: "Las coordenadas son latitud : \(lat ?? 0) & y longitud \(lon ?? 0)& altitud : \(altitud ?? 0)", preferredStyle: .alert)
        let accion = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(accion)
        present(alert, animated: true)
        
        let localizacion = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        let spanMapa = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion (center: localizacion, span: spanMapa)
        mapa.setRegion(region, animated: true)
        mapa.showsUserLocation = true
    }
    @IBOutlet weak var mapa: MKMapView!
    
    @IBOutlet weak var buscador: UISearchBar!
    
    
}

extension ViewController: CLLocationManagerDelegate, UISearchBarDelegate{
    
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
                    self.trazarRuta(coordDestino: destinoRuta.coordinate)
                    
                }else{
                    print("Error al encontrar direccion \(error?.localizedDescription)")
                    
                }
            }
        }
    }
    
}

