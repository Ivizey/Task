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
    @IBOutlet private weak var searchField: UITextField!
    var presenter: BreweriesViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let placeholder = NSMutableAttributedString()
        let image = NSTextAttachment()
        image.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.lightGray)
        placeholder.append(NSAttributedString(attachment: image))
        placeholder.append(NSAttributedString(string: " Search"))
        
        searchField.attributedPlaceholder = placeholder

        tableView.register(UINib(nibName: "BreweryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BreweryTableViewCell")
    }
}

extension BreweryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.breweries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryTableViewCell", for: indexPath) as! BreweryTableViewCell
        let brewery = presenter.breweries?[indexPath.row]
        cell.setupCell(brewery: brewery)
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
        presenter.tapOnTheItem(location: location)
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
