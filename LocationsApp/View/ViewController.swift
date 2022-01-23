//
//  ViewController.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 19/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let location = CLLocationManager()
    let range: Double = 40000
    //let pointer = UIImageView(image: UIImage(systemName: "mappin"))
    //let pin = MKAnnotation.self
    var myPointLat: Double?
    var myPointLong: Double?
    var myPoint: CLLocationCoordinate2D?
    var selectLocation: [Location] = []
    var point = 0
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let service = GetLocations()
        service.getLocation { [weak self] (locationsReceived) in
            
            guard let self = self else { return }
            
            if let locationsReceived = locationsReceived {
                self.selectLocation = locationsReceived
                self.point = self.selectLocation.count
                while self.i < self.point {
                    let loc = self.selectLocation[self.i]
                    
                    if let lat = loc.properties.lat,
                       let lon = loc.properties.lon,
                       let last = loc.properties.categories?.last {
                        
                        let pin = Pin(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon), title: loc.properties.address_line1!, subtitle: loc.properties.address_line2!, category: last)
                        
                        DispatchQueue.main.async {
                            self.mapView.addAnnotation(pin)
                        }
                    }
                    self.i = self.i+1
                  //  self.centerViewOnUser()
                    self.mapView.delegate = self
                }
            }
        }
        
        checkLocationServices()
        /*
        
         */
        mapView.showsUserLocation = true
        //location.stopUpdatingLocation()
        //centerViewOnUser()
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 4.55015605, longitude: -74.24083797857142)
        location.desiredAccuracy = kCLLocationAccuracyBest
        //mapView.showsUserLocation = true
        //centerViewOnUser()
        mapView.isZoomEnabled = true
        //pointer.translatesAutoresizingMaskIntoConstraints = false
        //pointer.tintColor = .red
        //view.addSubview(pointer)
        /*
        point = selectLocation.count
        print(selectLocation.count)
        while i < point {
            let loc = selectLocation[i]
            let pin = Pin(coordinate: CLLocationCoordinate2D(latitude: loc.properties.lat!, longitude: loc.properties.lon!))
            mapView.addAnnotation(pin)
            i = i+1
            print(i)
        }
        */
      //  let pin = Pin(coordinate: mapView.centerCoordinate)
       // mapView.addAnnotation(pin)
      //  let pinTwo = Pin(coordinate: CLLocationCoordinate2D(latitude: 4.495135100000001, longitude: -74.25815818555029))
      //  mapView.addAnnotation(pinTwo)
        
      //  let myPin = Pin(coordinate: myPoint!)
      //  mapView.addAnnotation(myPin)
        
        //NSLayoutConstraint.activate([
         //   pointer.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -14.5),
          //  pointer.centerXAnchor.constraint(equalTo: mapView.centerXAnchor)
        //])
        //mapView.showsUserLocation = true
        //centerViewOnUser()
        
    }

    
    func centerViewOnUser() {
     //  guard let myLocation = location.location?.coordinate else {
       //     print("No entra")
     //       return
     //  }
        
       // print(myLocation.latitude)
       // print(myLocation.longitude)
        let coordinateRegion = MKCoordinateRegion.init(center: mapView.centerCoordinate, latitudinalMeters: range, longitudinalMeters: range)
        mapView.setRegion(coordinateRegion, animated: true)
       // myPoint = CLLocationCoordinate2D(latitude: myLocation.latitude, longitude: myLocation.longitude)
       // myPointLat = myLocation.latitude
       // myPointLong = myLocation.longitude
    }
    
    func checkLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else  {
            return
        }
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        
        checkAuthorization()
    }
    
   
    func checkAuthorization() {
        
        print("Aqui entra")
        switch CLLocationManager.authorizationStatus() {
            
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUser()
            location.startUpdatingLocation()
            
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
            centerViewOnUser()
            location.startUpdatingLocation()
            break
        case .denied:
            
            break
        case .notDetermined:
           
            location.requestWhenInUseAuthorization()
        case .restricted:
           
            break
        default:
            
            break
        }
    }

}
/*
 private func checkAuthorizationForLocation() {
     switch CLLocationManager.authorizationStatus() {
     case .authorizedWhenInUse, .authorizedAlways:
         mapView.showsUserLocation = true
         locationManager.startUpdatingLocation()
         break
     case .denied:
         // Here we must tell user how to turn on location on device
         break
     case .notDetermined:
         locationManager.requestWhenInUseAuthorization()
     case .restricted:
             // Here we must tell user that the app is not authorize to use location services
         break
     @unknown default:
         break
     }
 }
 */

/*
 
 func centerViewOnUser() {
       let centerRegion = MKCoordinateRegion.init(center: selectedMap.centerCoordinate, latitudinalMeters: range, longitudinalMeters: range)
       selectedMap.setRegion(centerRegion, animated: true)
   }
 private let pointer = UIImageView(image: UIImage(systemName: "mappin"))

 private func layoutUI() {
     ...
     pointer.translatesAutoresizingMaskIntoConstraints = false
     pointer.tintColor = .red
     ...
     view.addSubview(pointer)
         
     NSLayoutConstraint.activate([
         ...
         pointer.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -14.5),
         pointer.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
         pointer.widthAnchor.constraint(equalToConstant: 27),
         pointer.heightAnchor.constraint(equalToConstant: 29)
     ])
 }
 */

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
 
 */
