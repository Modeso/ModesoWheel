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
        guard let view = Bundle(for: self.classForCoder).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {
            return nil
        }
        view.frame = bounds
        self.addSubview(view)
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        return view
    }
}
