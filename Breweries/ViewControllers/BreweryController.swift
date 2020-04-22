//
//  BreweryController.swift
//  Breweries
//
//  Created by Pavel Bondar on 15.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class BreweryController: UIViewController {
    @IBOutlet private weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var textField: UITextField!
    private let breweriesRepositoryImpl = BreweriesRepositoryImpl.makeDefault()
    private var brewery = [Brewery]() {
        didSet {
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.imagePlaceholder(image: UIImage(systemName: "magnifyingglass"), string: "Search")
        getBrewery(search: nil)
    }
    
    @IBAction func searchAction(_ sender: UITextField) {
        guard let search = sender.text else { return }
        getBrewery(search: search)
    }
    
    @objc private func openMapView(_ sender: UIButton) {
        let brewery = self.brewery[sender.tag]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapView") as! MapController
        vc.location = Location(title: brewery.name, locationName: brewery.city, coordinate: CLLocationCoordinate2D(latitude: brewery.latitude, longitude: brewery.longitude))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func openLink(_ sender: UIButton) {
        let vc = SFSafariViewController(url: URL(string: brewery[sender.tag].websiteUrl)!)
        self.present(vc, animated: true, completion: nil)
    }
    
    private func getBrewery(search: String?) {
        breweriesRepositoryImpl.fetchBrewery(search: search) { brewery in
            self.brewery = brewery
        }
    }
}

extension BreweryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brewery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BreweryTableViewCell
        cell.setDataLabel(brewery: self.brewery[indexPath.row], index: indexPath.row)
        cell.getMapButton().addTarget(self, action: #selector(openMapView(_:)), for: .touchUpInside)
        cell.getLinkButton().addTarget(self, action: #selector(openLink(_:)), for: .touchUpInside)
        return cell
    }
}

