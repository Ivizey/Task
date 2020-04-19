//
//  MapController.swift
//  Breweries
//
//  Created by Pavel Bondar on 15.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {
    @IBOutlet weak private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openMap(location: Location(
            title: "Avondale Brewing Co",
            locationName: "201 41st St S",
            coordinate: CLLocationCoordinate2D(
                latitude: 33.524521,
                longitude: -86.774322)
            )
        )
    }
    
    // MARK: - openMap
    private func openMap(location: Location) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location.coordinate
        annotation.title = location.title
        annotation.subtitle = location.locationName
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        mapView.translatesAutoresizingMaskIntoConstraints = true
    }
}
