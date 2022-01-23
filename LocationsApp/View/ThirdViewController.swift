//
//  ThirdViewController.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 21/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit
import MapKit

class ThirdViewController: UIViewController {

    var showLocation: Location?
    let range: Double = 10000
    
    @IBOutlet weak var selectedMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        selectedMap.delegate = self
        selectedMap.centerCoordinate = CLLocationCoordinate2D(latitude: (showLocation?.properties.lat)!, longitude: (showLocation?.properties.lon)!)
        let pin = Pin(coordinate: selectedMap.centerCoordinate, title: (showLocation?.properties.address_line1)!, subtitle: (showLocation?.properties.address_line2)!, category: (showLocation?.properties.categories?.last)!)
        selectedMap.addAnnotation(pin)
        centerViewOnUser()
    
 }
    
    func centerViewOnUser() {
        let centerRegion = MKCoordinateRegion.init(center: selectedMap.centerCoordinate, latitudinalMeters: range, longitudinalMeters: range)
        selectedMap.setRegion(centerRegion, animated: true)
    }
}

extension ThirdViewController: MKMapViewDelegate {
    
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
