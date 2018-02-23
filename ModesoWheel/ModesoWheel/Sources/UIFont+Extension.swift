//
//  UIFont+Extension.swift
//  Break Even
//
//  Created by ModesoEs on 12/5/17.
//  Copyright © 2017 Modeso. All rights reserved.
//

import UIKit

extension UIFont {
	enum LetterSpacing {
		static let narrowLight = 0.8
        static let none = 0.0
		static let narrow = 0.9
		static let medium = 1.2
		static let wide = 1.5
	}
	class func wheelOptionsFont() -> UIFont {
		return UIFont.systemFont(ofSize: 36.0, weight: UIFont.Weight.medium)
	}
	class func wheelTitleFont() -> UIFont {
		return UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.regular)
	}
}
