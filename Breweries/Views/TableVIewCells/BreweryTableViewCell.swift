//
//  BreweryTableViewCell.swift
//  Breweries
//
//  Created by Pavel Bondar on 20.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var breweryTypeLabel: UILabel!
    @IBOutlet private weak var streetLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var postalCodeLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var openMapButton: UIButton!
    @IBOutlet private weak var openWebsiteButton: UIButton!
    
    func setDataLabel(brewery: Brewery, index: Int) {
        nameLabel.text = brewery.name
        breweryTypeLabel.text = brewery.breweryType
        streetLabel.text = brewery.street
        cityLabel.text = brewery.city
        stateLabel.text = brewery.state
        postalCodeLabel.text = brewery.postalCode
        countryLabel.text = brewery.country
        phoneLabel.text = brewery.phone
        openMapButton.tag = index
        openWebsiteButton.tag = index
        openWebsiteButton.setTitle(brewery.websiteUrl, for: .normal)
    }
    
    func getMapButton() -> UIButton {
        return openMapButton
    }
    
    func getLinkButton() -> UIButton {
        return openWebsiteButton
    }
}
