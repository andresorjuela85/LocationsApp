//
//  ViewController.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 19/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let range: Double = 40000
    var myPointLat: Double?
    var myPointLong: Double?
    var myPoint: CLLocationCoordinate2D?
    var selectLocation: [Location] = []
    var point = 0
    var i = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
      
        let service = GetLocations()
        service.getLocation { (locationsReceived) in
            
            if let locationsReceived = locationsReceived {
                self.selectLocation = locationsReceived
                self.point = self.selectLocation.count
                while self.i < self.point {
                    let loc = self.selectLocation[self.i]
                    if let lat = loc.properties.lat, let lon = loc.properties.lon,
                        let addressOne = loc.properties.address_line1, let addressTwo = loc.properties.address_line2,
                        let last = loc.properties.categories?.last {
                        let pin = Pin(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: addressOne, subtitle: addressTwo, category: last)
                        self.mapView.addAnnotation(pin)
                    }
                    self.i = self.i+1
                    self.mapView.delegate = self
                }
            }
        }
        
    }
    
    
    func centerViewOnUser() {
        guard let myLocation = locationManager.location?.coordinate else {
            myPointLat = 4.579956599324831
            myPointLong = -74.08750386243297

            if let myPointLat = myPointLat, let myPointLong = myPointLong {
                myPoint = CLLocationCoordinate2D(latitude: myPointLat, longitude: myPointLong)
                if let myPoint = myPoint {
                    let coordinateRegion = MKCoordinateRegion.init(center: myPoint, latitudinalMeters: range, longitudinalMeters: range)
                    mapView.setRegion(coordinateRegion, animated: true)
                    let pinUser = PinUser(coordinate: myPoint)
                    mapView.addAnnotation(pinUser)
                }
            }
            return
        }
        
        let coordinateRegion = MKCoordinateRegion.init(center: myLocation, latitudinalMeters: range, longitudinalMeters: range)
        mapView.setRegion(coordinateRegion, animated: true)
        myPoint = CLLocationCoordinate2D(latitude: myLocation.latitude, longitude: myLocation.longitude)
        myPointLat = myLocation.latitude
        myPointLong = myLocation.longitude
    }
    
    func checkLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else  {
            return
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        checkAuthorization()
    }
    
    
    func checkAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
            
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUser()
            locationManager.startUpdatingLocation()
            
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
            centerViewOnUser()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            
            break
        default:
            
            break
        }
    }
    
}


extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let image = annotation as? Pin
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.animatesDrop = true
        view.canShowCallout = true
        let thumbnailImageView = UIImageView(frame: CGRect(x:0, y:0, width: 59, height: 59))
        thumbnailImageView.image = image?.thumbImage
        view.leftCalloutAccessoryView = thumbnailImageView
        return view
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    }
}

/*
 4.579956599324831, -74.08750386243297
 */
