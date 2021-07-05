//
//  UnboardingViewController.swift
//  Farmacias
//
//  Created by Mac2 on 04/07/21.
//

import UIKit

class UnboardingViewController: UIViewController {

    @IBOutlet weak var unboarding: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    var diapositivas: [OnboardingDiapositiva] = []
    
    var paginaActual = 0 {
            didSet {
                pageControl.currentPage = paginaActual
                if paginaActual == diapositivas.count - 1 {
                    siguiemteBtn.setTitle("Empezar", for: .normal)
                } else {
                    siguiemteBtn.setTitle("Siguiente", for: .normal)
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diapositivas = [
                   OnboardingDiapositiva(titulo: "Hola Bieenvenido a Farmacias Leaf", descripcion: "Aqui podras ver la informacian de las Farmacias con las que se cuenta, asi como consulta del Vademecum digital", imagen: #imageLiteral(resourceName: "farmacias-logo")),
                   OnboardingDiapositiva(titulo: "Registrate", descripcion: "Solo necesitas registrar un correo y contraseña o con una cuenta de Google", imagen: #imageLiteral(resourceName: "1")),
                   OnboardingDiapositiva(titulo: "Apartado de Farmacias", descripcion: "Aqui podras ver todas las Farmacias Registradas, y ver la informacion de cada una, y tambien podras dar de alta una nueva Farmacia", imagen: #imageLiteral(resourceName: "2")),
                   OnboardingDiapositiva(titulo: "Apartado de Farmacia Sucursal", descripcion: "Aqui podras ver la informacion de la farmacia seleccionada, los medicamentos con los que cuenta, ver la ubicacion de la sucursal en el mapa, asi como trazar tu ruta para llegar", imagen: #imageLiteral(resourceName: "3")),
                   OnboardingDiapositiva(titulo: "Busqueda de medicamentos", descripcion: "Aqui podras buscar algun medicamento en el Vademecum digital, para ver la informacion, asi como principio activo, indicaciones, etc.", imagen: #imageLiteral(resourceName: "4")),
                   OnboardingDiapositiva(titulo: "Apartado de Proveedores", descripcion: "Aqui podras ver todos los Proveedores que se tienen registrados, asi como actualizar su informacion y registrar nuevos", imagen: #imageLiteral(resourceName: "5"))
               ]
               unboarding.delegate = self
               unboarding.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var siguiemteBtn: UIButton!
    
    
    @IBAction func siguienteClickBtn(_ sender: UIButton) {
        
        //Si estamos en la última diapositiva ir a HOME
                if paginaActual == diapositivas.count - 1 {
                    let controlador = storyboard?.instantiateViewController(identifier: "HOMEVC") as! UIViewController
                    controlador.modalPresentationStyle = .fullScreen
                    controlador.modalTransitionStyle = .crossDissolve
                    
                    present(controlador, animated: true, completion: nil)
                } else {
                    paginaActual += 1
                    let indexPath = IndexPath(item: paginaActual, section: 0)
                    unboarding.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
            }
    
    
    
}


extension UnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return diapositivas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = unboarding.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        celda.configurar(diapositiva: diapositivas[indexPath.row])
        return celda
    }
 
    
}

extension UnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: unboarding.frame.width, height: unboarding.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let ancho = scrollView.frame.width
        paginaActual = Int(scrollView.contentOffset.x/ancho)
        
    }
}
