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
    
    private func removeFromCell(_ view: UIView) {
        view.isHidden = true
        stackView.removeArrangedSubview(view)
    }
    
    private func setToCell(_ view: UIView) {
        view.isHidden = false
        stackView.addArrangedSubview(view)
    }
    
    func setupCell(brewery: Brewery?) {
        guard let brewery = brewery else { return }
        let cellData = NSMutableAttributedString()
        let attr = NSAttributedString()
        cellData.append(attr.title(brewery.name, 20))
        cellData.append(attr.text("Brewery type: ", brewery.breweryType))
        cellData.append(attr.text("Street: ", brewery.street))
        cellData.append(attr.text("City: ", brewery.city))
        cellData.append(attr.text("State: ", brewery.state))
        cellData.append(attr.text("Postal code: ", brewery.postalCode))
        cellData.append(attr.text("Country: ", brewery.country))
        cellData.append(attr.text("Phone: ", brewery.phone))
        cellData.append(attr.text("Tag: ", brewery.tagList.first))
        contentLabel.attributedText = cellData
        
        if brewery.websiteUrl == nil || brewery.websiteUrl?.count ?? 0 <= 0 {
            removeFromCell(linkButton)
        } else {
            linkButton.linkButton.setAttributedTitle(NSAttributedString().setButtonTitle(title: brewery.websiteUrl!), for: .normal)
            linkButton.linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
            setToCell(linkButton)
        }

        if brewery.longitude == nil || brewery.latitude == nil {
            removeFromCell(mapButton)
        } else {
            mapButton.showMapButton.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
            setToCell(mapButton)
        }
    }
    
    @objc func linkButtonTapped(sender: UIButton) {
        guard let webURL = brewery?.websiteUrl else { return }
        if let url = URL(string: webURL) {
            self.delegate?.linkButtonTapped(cell: self, url: url)
        }
    }
    
    @objc func mapButtonTapped(sender: UIButton) {
        guard let title = brewery?.name, let locationName = brewery?.street,
            let latitude = brewery?.latitude, let longitude = brewery?.longitude
            else { return }
        
        let location = Location(title: title, locationName: locationName,
                                latitude: latitude, longitude: longitude)
        self.delegate?.mapButtonTapped(cell: self, location: location)
    }
}
