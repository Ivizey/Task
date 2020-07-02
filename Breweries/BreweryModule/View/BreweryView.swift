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
    private var timer: Timer?
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
    @IBAction func searchFieldAction(_ sender: UITextField) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.presenter.getBreweries(search: sender.text ?? "")
        })
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
        guard let latitude = Double(String(brewery?.latitude ?? "0.0")) else { return }
        guard let longitude = Double(String(brewery?.longitude ?? "0.0")) else { return }
        let location = Location(title: brewery?.name,
                                locationName: brewery?.city,
                                coordinate: CLLocationCoordinate2D(
                                    latitude: latitude,
                                    longitude: longitude
            )
        )
        presenter.tapOnTheItem(location: location)
    }
}

extension BreweryView: BreweriesViewProtocol {
    func succes() {
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
