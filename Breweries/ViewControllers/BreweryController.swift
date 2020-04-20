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
    @IBOutlet private weak var textField: UITextField!
    private let network = Network()
    private var brewery = [Brewery]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchPlaceholder()
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
    
    private func setSearchPlaceholder() {
        let fullString = NSMutableAttributedString()
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.lightGray)
        let imageString = NSAttributedString(attachment: imageAttachment)
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: " Search"))
        textField.attributedPlaceholder = fullString
    }
}

extension BreweryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brewery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BreweryTableViewCell
        let brewery = self.brewery[indexPath.row]
        cell.nameLabel.text = brewery.name
//        cell.descriptionLabel.text = "Brewery type: \(brewery.breweryType)\nCountry: \(brewery.country)\nCity: \(brewery.city)"
        return cell
    }
}

