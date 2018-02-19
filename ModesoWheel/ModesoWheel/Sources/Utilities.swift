//
//  Utilities.swift
//  Break Even
//
//  Created by ModesoEs on 12/7/17.
//  Copyright © 2017 Modeso. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    /**
     attributedText creates attributed string using given parameters
     
     Parameter:
     - text: string value.
     - font: UIFont to be set for thr sull range of text.
     - letterSpacing: float value that presents letter spacing for text.
     - color: UIColor to be set for full range of text.
	
	 Returns:
	 - attributedText: generated NSMutableAttributedString objects.
     */
    static func attributedText(_ text: String, font: UIFont, letterSpacing: Double, color: UIColor) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.kern: letterSpacing, NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color])
        return attributedText
    }
}
