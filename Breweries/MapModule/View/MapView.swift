//
//  MapController.swift
//  Breweries
//
//  Created by Pavel Bondar on 15.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIViewController {
    @IBOutlet weak private var mapView: MKMapView!
    var presenter: MapViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setTitle()
        presenter.setLocation()
    }
}

extension MapView: MapViewProtocol {
    func setTitle(title: String?) {
        self.title = title
    }
    
    func setLocation(location: Location?) {
        guard let location = location else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location.coordinate
        annotation.title = location.title
        annotation.subtitle = location.locationName
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
}
