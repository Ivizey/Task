//
//  TextAttribute.swift
//  Breweries
//
//  Created by Pavel Bondar on 20.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

protocol TextAttributeProtocol {
    func setTitle(title: String?, size: CGFloat) -> NSAttributedString
    func setText(description: String, text: String?) -> NSAttributedString
}

class TextAttribute: TextAttributeProtocol {
    let charter = UIFontDescriptor(name: "Charter", size: 20)
    let paragraphStyle = NSMutableParagraphStyle()
    
    func setTitle(title: String?, size: CGFloat) -> NSAttributedString {
        guard let title = title else { return NSAttributedString() }
        paragraphStyle.lineSpacing = 5
        let titleAttributed: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(descriptor: charter, size: size),
            .foregroundColor: UIColor.darkGray]
        return NSAttributedString(string: title + "\n", attributes: titleAttributed)
    }
    
    func setText(description: String, text: String?) -> NSAttributedString {
        guard let text = text else { return NSMutableAttributedString() }
        if text.count <= 0 {
            return NSMutableAttributedString()
        }
        paragraphStyle.lineSpacing = 5
        let subtitleAttributed: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(descriptor: charter, size: 14),
            .foregroundColor: UIColor.darkGray]
        
        let descriptionAttributed: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(descriptor: charter, size: 14),
            .foregroundColor: UIColor.lightGray]
        
        let textWithDescription = NSMutableAttributedString(string: description, attributes: descriptionAttributed)
        textWithDescription.append(NSAttributedString(string: text + "\n", attributes: subtitleAttributed))
        
        return textWithDescription
    }
    
    func setButtonTitle(title: String) -> NSAttributedString {
        let buttonAttributed: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: charter, size: 14),
            .foregroundColor: UIColor.darkGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        return NSAttributedString(string: title, attributes: buttonAttributed)
    }
    
    func setSearchPlaceholder() -> NSMutableAttributedString {
        let placeholder = NSMutableAttributedString()
        let image = NSTextAttachment()
        image.image = UIImage(systemName: "magnifyingglass")?.withTintColor(.lightGray)
        placeholder.append(NSAttributedString(attachment: image))
        placeholder.append(NSAttributedString(string: " Search"))
        return placeholder
    }
}
