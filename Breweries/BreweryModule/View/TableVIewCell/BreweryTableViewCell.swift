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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellViewContent.layer.borderColor = #colorLiteral(red: 0.2820236385, green: 0.6055960655, blue: 0.1114733592, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupCell(brewery: Brewery?) {
        guard let brewery = brewery else { return }
        let charter = UIFontDescriptor(name: "Charter", size: 20)
        
        let titleAttributed: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: charter, size: 20),
            .foregroundColor: UIColor.darkGray]
        
        let subtitleAttributed: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: charter, size: 14),
            .foregroundColor: UIColor.darkGray]
        
        let descriptionAttributed: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: charter, size: 14),
            .foregroundColor: UIColor.lightGray]
        
        let cellData = NSMutableAttributedString()
        let name = NSAttributedString(string: brewery.name + "\n", attributes: titleAttributed)
        let street = NSMutableAttributedString(string: "Street: ", attributes: descriptionAttributed)
        street.append(NSAttributedString(string: brewery.street + "\n", attributes: subtitleAttributed))
        let breweryType = NSMutableAttributedString(string: "Brewery type: ", attributes: descriptionAttributed)
        breweryType.append(NSAttributedString(string: brewery.breweryType + "\n", attributes: subtitleAttributed))
        let city = NSMutableAttributedString(string: "City: ", attributes: descriptionAttributed)
        city.append(NSAttributedString(string: brewery.city + "\n", attributes: subtitleAttributed))
        let state = NSMutableAttributedString(string: "State: ", attributes: descriptionAttributed)
        state.append(NSAttributedString(string: brewery.state + "\n", attributes: subtitleAttributed))
        let postalCode = NSMutableAttributedString(string: "Postal code: ", attributes: descriptionAttributed)
        postalCode.append(NSAttributedString(string: brewery.postalCode + "\n", attributes: subtitleAttributed))
        let country = NSMutableAttributedString(string: "Country: ", attributes: descriptionAttributed)
        country.append(NSAttributedString(string: brewery.country + "\n", attributes: subtitleAttributed))
        let phone = NSMutableAttributedString(string: "Phone: ", attributes: descriptionAttributed)
        phone.append(NSAttributedString(string: brewery.phone + "\n", attributes: subtitleAttributed))
        let websiteUrl = NSMutableAttributedString(string: "Website: ", attributes: descriptionAttributed)
        websiteUrl.append(NSAttributedString(string: brewery.websiteUrl + "\n", attributes: subtitleAttributed))
        let tagList = NSMutableAttributedString(string: "Tag: ", attributes: descriptionAttributed)
        tagList.append(NSAttributedString(string: brewery.tagList.first ?? "", attributes: subtitleAttributed))
        
        cellData.append(name)
        cellData.append(breweryType)
        cellData.append(street)
        cellData.append(city)
        cellData.append(state)
        cellData.append(postalCode)
        cellData.append(country)
        cellData.append(phone)
        cellData.append(websiteUrl)
        cellData.append(tagList)
        
        contentLabel.attributedText = cellData
    }
    
}
