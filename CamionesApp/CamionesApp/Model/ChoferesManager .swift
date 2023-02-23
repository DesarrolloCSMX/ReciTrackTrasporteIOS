//
//  ChoferesManager .swift
//  CamionesApp
//
//  Created by Johnne Lemand on 02/02/23.
//

import Foundation

protocol ChoferManagerDelegate{
    func mostrarChoferes(listaChoferes:[ChoferesModelo])
    func mostrarError(cualError: String)
}

struct ChoferesManager {
    
    var delegado: ChoferManagerDelegate?
    
    let choferesURL = "http://reci-track.com/api/LoginChofer?"
    
    func obtenerChoferes(){
        if let url = URL (string: choferesURL){
            let session = URLSession(configuration: .default)
            
            let tarea = session.dataTask(with: url) { datos, _, error in
                if let e = error {
                    print("error del servidor: \(e.localizedDescription)")
                    delegado?.mostrarError(cualError: "error del servidor: \(e.localizedDescription)")
                }
                //Datos
                if let datosSeguros = datos{
                    //Decodificar la datasegura
                    let decoder =  JSONDecoder()
                    
                    do{
                        let dataDecodificada = try decoder.decode([ChoferesModelo].self, from: datosSeguros)
                        //Mandar la lista de objetos al VC a traves del delegado
                        delegado?.mostrarChoferes(listaChoferes: dataDecodificada)
                        
                    }catch{
                        print("Debug:error al decodificar \(error.localizedDescription)")
                        delegado?.mostrarError(cualError:"Debug:error al decodificar \(error.localizedDescription)" )
                    }
                    
                }
            }
            tarea.resume()
        }
    
    }
}
