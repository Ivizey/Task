//
//  BreweryView.swift
//  Breweries
//
//  Created by Pavel Bondar on 15.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class BreweryView: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchField: UITextField!
    private var timer: Timer?
    var presenter: BreweriesViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.setSearchPlaceholder()
        tableView.register(UINib(nibName: "BreweryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BreweryTableViewCell")
    }
    
    @IBAction func searchFieldAction(_ sender: UITextField) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.presenter.getBreweries(search: sender.text ?? nil) 
        })
    }
    
    private func tableViewScroll() {
        if presenter.breweries?.count ?? 0 > 0  {
            tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
}

extension BreweryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.breweries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreweryTableViewCell", for: indexPath) as! BreweryTableViewCell
        let brewery = presenter.breweries?[indexPath.row]
        cell.delegate = self
        cell.brewery = brewery
        return cell
    }
}

extension BreweryView: BreweriesViewProtocol {
    func succes() {
        tableView.reloadData()
        tableViewScroll()
    }
}

extension BreweryView: CellSubclassDelegate {
    func linkButtonTapped(cell: BreweryTableViewCell, url: URL) {
        presenter.openBrowser(url: url)
    }
    
    func mapButtonTapped(cell: BreweryTableViewCell, location: Location) {
        presenter.openMapView(location: location)
    }
}
