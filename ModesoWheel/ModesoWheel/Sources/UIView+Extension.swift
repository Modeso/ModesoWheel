//
//  UIView+Extension.swift
//  Break Even
//
//  Created by Reem Hesham on 12/18/17.
//  Copyright © 2017 Modeso. All rights reserved.
//

import UIKit

extension UIView {
    /** LoadFromNib Method
     Load the UIView from the .xib file using the Bundle and nib name
     */
    @discardableResult func loadFromNib < T: UIView >() -> T? {
//			let podBundle = Bundle(for: self.classForCoder)
//		guard let bundleURL = podBundle.url(forResource: "ModesoWheel", withExtension: "bundle"), let bundle = Bundle(url: bundleURL)else {
//				return nil
//			}
        guard let view = UINib(nibName: "ModesoWheel", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? T else {
            return nil
        }
        view.frame = bounds
        self.addSubview(view)
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        return view
    }
}
