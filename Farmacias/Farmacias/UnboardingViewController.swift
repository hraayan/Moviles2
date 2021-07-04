//
//  UnboardingViewController.swift
//  Farmacias
//
//  Created by Mac2 on 04/07/21.
//

import UIKit

class UnboardingViewController: UIViewController {

    @IBOutlet weak var unboarding: UICollectionView!
    
    var diapositivas: [OnboardingDiapositiva] = []
    
    var paginaActual = 0 {
            didSet {
                pageControl.currentPage = paginaActual
                if paginaActual == diapositivas.count - 1 {
                    botonSiguiente.setTitle("Empezar", for: .normal)
                } else {
                    botonSiguiente.setTitle("Siguiente", for: .normal)
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var siguiemteBtn: UIButton!
    
    

}
