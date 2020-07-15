//
//  LinkButton.swift
//  Breweries
//
//  Created by Pavel Bondar on 08.07.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class LinkButton: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var linkButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LinkButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
