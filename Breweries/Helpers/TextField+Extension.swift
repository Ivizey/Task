//
//  TextField+Extension.swift
//  Breweries
//
//  Created by Pavel Bondar on 13.07.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UITextField

extension UITextField {
    func setSearchPlaceholder() {
        let placeholder = NSMutableAttributedString()
        let image = NSTextAttachment()
        image.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.lightGray)
        placeholder.append(NSAttributedString(attachment: image))
        placeholder.append(NSAttributedString(string: " Search"))
        self.attributedPlaceholder = placeholder
    }
}
