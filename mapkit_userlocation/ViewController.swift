//
//  ViewController.swift
//  mapkit_userlocation
//
//  Created by AamirR on 5/4/19.
//  Copyright © 2019 AamirR. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        
        self.checkLocationAuthorization()
    }
    
    func checkLocationAuthorization(authorizationStatus: CLAuthorizationStatus? = nil) {
        switch (authorizationStatus ?? CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .notDetermined:
            if locationManager == nil {
                locationManager = CLLocationManager()
                locationManager!.delegate = self
            }
            locationManager!.requestWhenInUseAuthorization()
        default:
            print("Location Servies: Denied / Restricted")
        }
    }
    
}

extension ViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.checkLocationAuthorization(authorizationStatus: status)
    }
    
}
