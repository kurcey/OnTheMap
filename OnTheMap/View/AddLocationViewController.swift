//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by user152630 on 6/16/19.
//  Copyright © 2019 user152630. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AddLocationViewController:  UIViewController  {
    let networkHelper = Network()
    let converter = Converter()
    let constants = Constants()
    let apiClient = APIClient()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var vSpinner : UIView?
    var pickedLocation: CLPlacemark?
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var linkTextField: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
    }
    
    @IBAction func findLocationButton(_ sender: Any) {
        func processAddress(placemarks: [CLPlacemark]?, error: Error?) -> Void{
            
            if (error == nil){
                DispatchQueue.main.async {
                    self.removeSpinner()
                    if (placemarks?.count ?? 0 > 0) {
                        self.pickedLocation  = placemarks?.first
                        self.performSegue(withIdentifier: "detailMapSegue", sender: self)
                    }
                    else {
                        self.removeSpinner()
                        self.networkHelper.showAlertMsg(presentView: self, title: "No results found", message: "nada")                    }
                }
            }
            else {
                DispatchQueue.main.async{
                    self.removeSpinner()
                    self.networkHelper.showAlertMsg(presentView: self, title: "Error retreving address", message: "\(error ?? "" as! Error)")
                }
            }
            
        }
        if (addressTextField.text == "" || linkTextField.text == ""){
            networkHelper.showAlertMsg(presentView: self, title: "Missing Fields", message: "Please fill in both username and password to continue ")
        }
        else{
            self.showSpinner(onView: self.view)
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressTextField?.text ?? "",  completionHandler:processAddress)        }
    }
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("hi")
        print( segue.destination )
        if segue.identifier == "detailMapSegue" {
            let controller = segue.destination as! AddLocationMapViewController
            controller.location = pickedLocation
            
        }
    }
    
}
