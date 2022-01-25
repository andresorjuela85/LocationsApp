//
//  SecondViewController.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 21/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var selectedLocation: [Location] = []
    var location: Location?
    
    
    @IBOutlet private weak var locationList: UITableView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = GetLocations()
        
        loaderView.isHidden = false
        
        service.getLocation { locationsReceived in
            
            DispatchQueue.main.async {
                self.loaderView.isHidden = true
                
                if let locationsReceived = locationsReceived {
                    self.selectedLocation = locationsReceived
                    self.locationList.dataSource = self
                    self.locationList.delegate = self
                    self.locationList.reloadData()
                }
            }
            
        }
        
        self.locationList.register(UINib(nibName: "locationCell", bundle: nil), forCellReuseIdentifier: "reuse")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let thirdView = segue.destination as? ThirdViewController
        {
            thirdView.showLocation = location
        }
    }
    
}

extension SecondViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let list = locationList.dequeueReusableCell(withIdentifier: "reuse", for: indexPath) as? locationCell else {
            return UITableViewCell()
        }
        
        list.configure(location: selectedLocation[indexPath.row])
        if let lat = selectedLocation[indexPath.row].properties.lat, let lon = selectedLocation[indexPath.row].properties.lon {
            list.distance(latTwo: lat, longTwo: lon)
        }
        return list
    }
    
    
}

extension SecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        location = selectedLocation[indexPath.row]
        performSegue(withIdentifier: "thirdViewSegue", sender: self)
    }
}

/*
 

 */
