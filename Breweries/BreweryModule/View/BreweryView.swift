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
        
        searchField.attributedPlaceholder = presenter.setSearchPlaceholder()
        tableView.register(UINib(nibName: "BreweryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BreweryTableViewCell")
    }
    @IBAction func searchFieldAction(_ sender: UITextField) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.presenter.getBreweries(search: sender.text ?? nil) 
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
        cell.brewery = brewery
        return cell
    }
}

extension BreweryView: BreweriesViewProtocol {
    func succes() {
        tableView.reloadData()
        if presenter.breweries?.count ?? 0 > 0  {
            tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
