//
//  MapViewController.swift
//  CamionesApp
//
//  Created by Johnne Lemand on 18/02/23.
//

import UIKit


class MapViewController: UIViewController {

    @IBOutlet weak var ButtonScan: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ButtonScan.layer.cornerRadius = ButtonScan.frame.width / 3
        ButtonScan.layer.masksToBounds = true
        
    }
    

    @IBAction func ScanButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "qr", sender: self)
    }
    

}
