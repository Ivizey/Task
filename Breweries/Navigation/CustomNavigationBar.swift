//
//  CustomNavigationBar.swift
//  Breweries
//
//  Created by Pavel Bondar on 16.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

@IBDesignable class CustomNavigationBar: UIView {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet private var contentView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: CustomNavigationBar.self)
        bundle.loadNibNamed("CustomNavigationBar", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
