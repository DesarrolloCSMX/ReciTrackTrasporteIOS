//
//  MenuViewController.swift
//  CamionesApp
//
//  Created by Johnne Lemand on 02/02/23.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet weak var usuernameLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func datosButton(_ sender: Any) {
        
    }
    
    @IBAction func entregarButton(_ sender: Any) {
        
    }
    
    @IBAction func viajesButton(_ sender: Any) {
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exit(0)
    }
    
}
