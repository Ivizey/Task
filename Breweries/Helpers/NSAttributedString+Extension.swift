//
//  NSAttributedString+Extension.swift
//  Breweries
//
//  Created by Pavel Bondar on 13.07.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func title(_ title: String?,_ size: CGFloat) -> NSAttributedString {
        guard let title = title else { return NSAttributedString() }
        let charter = UIFontDescriptor(name: "Charter", size: 20)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 5
        let titleAttributed: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont(descriptor: charter, size: size),
            .foregroundColor: UIColor.darkGray]
        return NSAttributedString(string: title + "\n", attributes: titleAttributed)
    }
    
    func text(_ description: String,_ text: String?) -> NSAttributedString {
        guard let text = text, text.count > 0 else { return NSAttributedString() }
        let charter = UIFontDescriptor(name: "Charter", size: 20)
        let paragraphStyle = NSMutableParagraphStyle()
        
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
        let charter = UIFontDescriptor(name: "Charter", size: 20)
        let buttonAttributed: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: charter, size: 14),
            .foregroundColor: UIColor.darkGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        return NSAttributedString(string: title, attributes: buttonAttributed)
    }
}
