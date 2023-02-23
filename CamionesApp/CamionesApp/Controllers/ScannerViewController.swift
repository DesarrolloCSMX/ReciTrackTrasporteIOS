//
//  ScannerViewController.swift
//  CamionesApp
//
//  Created by Johnne Lemand on 22/02/23.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController {

    var captureSession = AVCaptureSession()
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrame:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        intializeQrSacanner()
        
    }
    
    private func intializeQrSacanner(){
        
       // 1 paso
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:[.builtInDualCamera] , mediaType: .video, position: .back)
        
        guard let  captureDevice = discoverySession.devices.first else{
            
            print("No device found")
            
            return
        }
    
    
    do {
    
    let input = try! AVCaptureDeviceInput(device: captureDevice)
    
    captureSession.addInput(input)
    
    //2 paso
    let videoMetaDataOutput = AVCaptureMetadataOutput()
    captureSession.addOutput(videoMetaDataOutput)
    
    //3 paso
    
        videoMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        videoMetaDataOutput.metadataObjectTypes = [.qr]
    //4
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        qrCodeFrame = UIView()
        
        if qrCodeFrame == qrCodeFrame{
            qrCodeFrame.layer.borderColor = UIColor.green.cgColor
            qrCodeFrame.layer.borderWidth = 2.0
            
            view.addSubview(qrCodeFrame)
            view.bringSubviewToFront(qrCodeFrame)
        }
        
        captureSession.startRunning()
        
    } catch{
        
        print("error")
        return
    }
 
    

    }
}

extension ScannerViewController :  AVCaptureMetadataOutputObjectsDelegate{
 
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0{
            
            qrCodeFrame.frame = .zero
            print("No code found")
            return
        }
        
        let metadataObject = metadataObjects [0] as! AVMetadataMachineReadableCodeObject
        
        
        if metadataObject.type == .qr {
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject)
            qrCodeFrame.frame = barCodeObject!.bounds
            
            
            if metadataObject.stringValue == nil {
                
                print("Code value is == \(metadataObject.stringValue)")
            }
        }
    }
    
}

 
