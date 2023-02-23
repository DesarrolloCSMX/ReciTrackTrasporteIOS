//
//  ViewController.swift
//  CamionesApp
//
//  Created by Johnne Lemand on 31/01/23.
//

import UIKit
import Alamofire



struct Posts: Codable {
    let id: Int
    let telefono: Int
    let pass: String
}



struct ChoferModel: Decodable {
    let id : String
    let id_empresatransporte : String
    let nombres : String
    let apellidos:  String
    let telefono : String
    let pass : String
    let tipo : String
}


struct Chofer: Codable {
    let id, idPlanta, nombres, apellidos: String
    let licencia, telefono, pass, verificado: String
    let telefonoverificado, tipo, token, createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case idPlanta = "id_planta"
        case nombres, apellidos, licencia, telefono, pass, verificado, telefonoverificado, tipo, token
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}




class LoginViewController: UIViewController, UITextFieldDelegate {

    
    var activityView: UIActivityIndicatorView?
    @IBOutlet weak var telefonoTextField: UITextField!
    @IBOutlet weak var contraTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    
    func alertaMensaje(msj:String){
        let alerta = UIAlertController(title: "ERROR", message: msj, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
    
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let telefono = telefonoTextField.text!
        let pass = contraTextField.text!
    
        if telefono.count == 0 || pass.count == 0 {
            self.alertaMensaje(msj: "Introduce correo y contraseña")}
        
        showActivityIndicator()
        
        //print(telefonoTextField)
        //print(contraTextField)
        
        postMethod(telefono: "\(telefonoTextField.text!)", pass: "\(contraTextField.text!)")
        
    }
    
    
    func postMethod(telefono: String, pass: String){
        let url = URL(string: "http://reci-track.com/api/LoginChofer")!
        var request = URLRequest(url: url)
        
        request.setValue(
            "authToken",
            forHTTPHeaderField: "Authorization"
        )
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.setValue("cefa31bbcb2e11ec81768030496e73b4", forHTTPHeaderField: "app-key")
        
        var components = URLComponents()
        
        components.queryItems = [
            URLQueryItem(name: "telefono", value: "\(telefono)"),
            URLQueryItem(name: "pass", value: "\(pass)")
        ]
        
        let body = ["telefono": "\(telefono)",
                    "pass":"\(pass)"]
        
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                print("Debug: error \(error) \(error.localizedDescription)")
            } else if let data = data {
                print("Debug: data \(data)")
                
                let str = String(decoding: data, as: UTF8.self)
                print("Debug: str \(str)")
                let decoder = JSONDecoder()
                do {
                    let dataDecodificada = try decoder.decode(Chofer.self, from: data)
                    print("Debug: dataDecodificada \(dataDecodificada)")
                    print("Debug: id \(dataDecodificada.id)")
                    print("Debug: telefono \(dataDecodificada.telefono)")
                    print("Debug: pass \(dataDecodificada.pass)")
                    
                    DispatchQueue.main.async {
                        self.mostrarAlerta(titulo: "Inicio de sesión", mensaje: "Exitoso")
                        
                        //self.mostrarAlerta(titulo: "Data", mensaje: "\(dataDecodificada)")
                        
                        self.hideActivityIndicator()
                    }
                    
                } catch {
                    print("Debug: error al decodificar la data \(error.localizedDescription)")
                }
                
            } else {
                // Handle unexpected error
            }
        }
        task.resume()
    }
    
    func mostrarAlerta(titulo: String, mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let accionAceptar = UIAlertAction(title: "OK", style: .default) { _ in
            //Do something
            self.performSegue(withIdentifier: "login", sender: self)
        }
        alerta.addAction(accionAceptar)
        present(alerta, animated: true)
    }
    
    
    @IBAction func registrerButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://reci-track.mx/RegistroChofer")! as URL, options: [:], completionHandler: nil)
    }
    
    




}
