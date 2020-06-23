//
//  TextAttribute.swift
//  Breweries
//
//  Created by Pavel Bondar on 20.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

enum TextAttributeFor {
    case title(title: String, size: CGFloat)
    case text (description: String, text: String?)
}

protocol TextAttributeProtocol {
    func setAttribute(for: TextAttributeFor) -> NSAttributedString
}

class TextAttribute: TextAttributeProtocol {
    let charter = UIFontDescriptor(name: "Charter", size: 20)
    
    func setAttribute(for: TextAttributeFor) -> NSAttributedString {
        switch `for` {
        case .title(let title, let size):
            let titleAttributed: [NSAttributedString.Key: Any] = [
                .font: UIFont(descriptor: charter, size: size),
                .foregroundColor: UIColor.darkGray]
            return NSAttributedString(string: title + "\n", attributes: titleAttributed)
        case .text(let description, let text):
            guard let text = text else { return NSMutableAttributedString() }
            let subtitleAttributed: [NSAttributedString.Key: Any] = [
                .font: UIFont(descriptor: charter, size: 14),
                .foregroundColor: UIColor.darkGray]
            
            let descriptionAttributed: [NSAttributedString.Key: Any] = [
                .font: UIFont(descriptor: charter, size: 14),
                .foregroundColor: UIColor.lightGray]
            
            let textWithDescription = NSMutableAttributedString(string: description, attributes: descriptionAttributed)
            textWithDescription.append(NSAttributedString(string: text + "\n", attributes: subtitleAttributed))
            
            return textWithDescription
        }
    }
}
