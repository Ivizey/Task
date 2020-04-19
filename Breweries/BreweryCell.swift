//
//  BreweryCell.swift
//  Breweries
//
//  Created by Pavel Bondar on 18.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit
import SafariServices

class BreweryCell: UITableViewCell {
    @IBOutlet weak var verticalStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        verticalStack.layer.masksToBounds = true
//        verticalStack.layer.cornerRadius = 5
//        verticalStack.layer.borderWidth = 1
//        verticalStack.layer.borderColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
    }
    
    private func openLink(view: UIViewController, url: URL?) {
        guard let url = url else { return }
        let safariView = SFSafariViewController(url: url)
        view.present(safariView, animated: true, completion: nil)
    }
}
