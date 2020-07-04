//
//  BreweryTableViewCell.swift
//  Breweries
//
//  Created by Pavel Bondar on 17.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var cellViewContent: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    private let attribute = TextAttribute()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellViewContent.layer.borderColor = #colorLiteral(red: 0.2820236385, green: 0.6055960655, blue: 0.1114733592, alpha: 1)
    }
    
    func setupCell(brewery: Brewery?) {
        guard let brewery = brewery else { return }
        let cellData = NSMutableAttributedString()
        cellData.append(attribute.setAttribute(for: .title(title: brewery.name ?? "", size: 20)))
        cellData.append(attribute.setAttribute(for: .text(description: "Brewery type: ", text: brewery.breweryType)))
        if brewery.street?.count ?? 0 > 0 {
            cellData.append(attribute.setAttribute(for: .text(description: "Street: ", text: brewery.street)))
        }
        cellData.append(attribute.setAttribute(for: .text(description: "City: ", text: brewery.city)))
        cellData.append(attribute.setAttribute(for: .text(description: "State: ", text: brewery.state)))
        cellData.append(attribute.setAttribute(for: .text(description: "Postal code: ", text: brewery.postalCode)))
        cellData.append(attribute.setAttribute(for: .text(description: "Country: ", text: brewery.country)))
        if brewery.phone?.count ?? 0 > 0 {
            cellData.append(attribute.setAttribute(for: .text(description: "Phone: ", text: brewery.phone)))
        }
        cellData.append(attribute.setAttribute(for: .text(description: "Website: ", text: brewery.websiteUrl)))
        cellData.append(attribute.setAttribute(for: .text(description: "Tag: ", text: brewery.tagList.first)))
        
        contentLabel.attributedText = cellData
    }
    
}
