//
//  AddLocationMapViewController.swift
//  OnTheMap
//
//  Created by user152630 on 6/16/19.
//  Copyright © 2019 user152630. All rights reserved.
//

import MapKit
import UIKit

class AddLocationMapViewController: //MapViewController
    UIViewController
{
    
    var location : CLPlacemark? = nil
    

    @IBAction func finishButton(_ sender: Any) {
    }
    
    
    func placePin(_ pinLocation : CLPlacemark?){
        var annotations = [MKPointAnnotation]()
        
        let lat = pinLocation?.location?.coordinate.latitude as! Double
        let long = pinLocation?.location?.coordinate.latitude as! Double
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(pinLocation?.location)"
        //annotation.subtitle = mediaURL
        annotations.append(annotation)
        
        mapView.addAnnotations(annotations)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(location?.location?.coordinate.latitude)
        placePin(location)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
            
        }
    }
    
}

