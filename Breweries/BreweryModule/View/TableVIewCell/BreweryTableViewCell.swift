//
//  BreweryTableViewCell.swift
//  Breweries
//
//  Created by Pavel Bondar on 17.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

protocol CellSubclassDelegate: class {
    func linkButtonTapped(cell: BreweryTableViewCell, url: URL)
    func mapButtonTapped(cell: BreweryTableViewCell, location: Location)
}

class BreweryTableViewCell: UITableViewCell {
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var cellViewContent: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    weak var delegate: CellSubclassDelegate?
    private let attribute = TextAttribute()
    private let mapButton = MapButton()
    private let linkButton = LinkButton()
    var brewery: Brewery? {
        didSet {
            setupCell(brewery: brewery)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellViewContent.layer.borderColor = #colorLiteral(red: 0.2820236385, green: 0.6055960655, blue: 0.1114733592, alpha: 1)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    func setupCell(brewery: Brewery?) {
        guard let brewery = brewery else { return }
        let cellData = NSMutableAttributedString()
        cellData.append(attribute.setTitle(title: brewery.name, size: 20))
        cellData.append(attribute.setText(description: "Brewery type: ", text: brewery.breweryType))
        cellData.append(attribute.setText(description: "Street: ", text: brewery.street))
        cellData.append(attribute.setText(description: "City: ", text: brewery.city))
        cellData.append(attribute.setText(description: "State: ", text: brewery.state))
        cellData.append(attribute.setText(description: "Postal code: ", text: brewery.postalCode))
        cellData.append(attribute.setText(description: "Country: ", text: brewery.country))
        cellData.append(attribute.setText(description: "Phone: ", text: brewery.phone))
        cellData.append(attribute.setText(description: "Tag: ", text: brewery.tagList.first))
        contentLabel.attributedText = cellData
        
        if brewery.websiteUrl == nil || brewery.websiteUrl?.count ?? 0 <= 0 {
            linkButton.isHidden = true
            stackView.removeArrangedSubview(linkButton)
        } else {
            linkButton.isHidden = false
            linkButton.linkButton.setAttributedTitle(attribute.setButtonTitle(title: brewery.websiteUrl!), for: .normal)
            linkButton.linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(linkButton)
        }
        
        if brewery.longitude == nil || brewery.latitude == nil {
            mapButton.isHidden = true
            stackView.removeArrangedSubview(mapButton)
        } else {
            mapButton.isHidden = false
            mapButton.showMapButton.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(mapButton)
        }
    }
    
    @objc func linkButtonTapped(sender: UIButton) {
        guard let webURL = brewery?.websiteUrl else { return }
        if let url = URL(string: webURL) {
            self.delegate?.linkButtonTapped(cell: self, url: url)
        }
    }
    
    @objc func mapButtonTapped(sender: UIButton) {
        guard let title = brewery?.name,
            let locationName = brewery?.street,
            let latitude = brewery?.latitude,
            let longitude = brewery?.longitude
            else { return }
        
        let location = Location(title: title,
                                locationName: locationName,
                                latitude: latitude,
                                longitude: longitude)
        self.delegate?.mapButtonTapped(cell: self, location: location)
    }
}
