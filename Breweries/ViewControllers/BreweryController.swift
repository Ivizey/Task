//
//  BreweryController.swift
//  Breweries
//
//  Created by Pavel Bondar on 15.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class BreweryController: UIViewController {
    @IBOutlet private weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    private let network = Network()
    private var brewery = [Brewery]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getBrewery(search: nil)
    }
    
    private func getBrewery(search: String?) {
        network.fetchBrewery(search: search) { [weak self] brewery in
            DispatchQueue.main.async {
                self?.brewery = brewery
                self?.tableView.reloadData()
            }
        }
    }
}

extension BreweryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brewery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = brewery[indexPath.row].name
        cell.detailTextLabel?.text = brewery[indexPath.row].city
        return cell
    }
}

extension BreweryController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getBrewery(search: searchText)
    }
}
