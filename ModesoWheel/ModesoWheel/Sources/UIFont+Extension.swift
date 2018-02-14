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
	class func mbeMedium36Font() -> UIFont {
		return UIFont.systemFont(ofSize: 36.0, weight: UIFont.Weight.medium)
	}

	class func mbeMedium24Font() -> UIFont {
		return UIFont.systemFont(ofSize: 24.0, weight: UIFont.Weight.medium)
	}

	class func mbeMedium15Font() -> UIFont {
		return UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
	}

	class func mbeRegular15Font() -> UIFont {
		return UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.regular)
	}

	class func mbeSemiBold15Font() -> UIFont {
		return UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.semibold)
	}

	class func mbeRegular13Font() -> UIFont {
		return UIFont.systemFont(ofSize: 13.0, weight: UIFont.Weight.regular)
	}

	class func mbeLight12Font() -> UIFont {
		return UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.light)
	}
	
	class func mbeLight15Font() -> UIFont {
		return UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.light)
	}
}
