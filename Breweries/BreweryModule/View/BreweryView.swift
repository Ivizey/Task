//
//  BreweryView.swift
//  Breweries
//
//  Created by Pavel Bondar on 15.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import MapKit

class BreweryView: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var presenter: BreweriesViewPresenterProtocol!
}

extension BreweryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.breweries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let brewery = presenter.breweries?[indexPath.row]
        cell.textLabel?.text = brewery?.name
        cell.detailTextLabel?.text = brewery?.city
        return cell
    }
}

extension BreweryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brewery = presenter.breweries?[indexPath.row]
        let location = Location(title: brewery?.name,
                                locationName: brewery?.city,
                                coordinate: CLLocationCoordinate2D(
                                    latitude: brewery?.latitude ?? 0,
                                    longitude: brewery?.longitude ?? 0
            )
        )
        let mapView = AsselderModuleBuilder.createMapModule(location: location)
        navigationController?.pushViewController(mapView, animated: true)
    }
}

extension BreweryView: BreweriesViewProtocol {
    func succes() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
