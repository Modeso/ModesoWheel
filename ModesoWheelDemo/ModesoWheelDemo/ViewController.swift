//
//  ViewController.swift
//  ModesoWheelDemo
//
//  Created by Esraa Yasser on 2/12/18.
//  Copyright © 2018 Modeso. All rights reserved.
//

import UIKit
import ModesoWheel

class ViewController: UIViewController {
    
    enum Const {
        static let wheelBottomSpacing: CGFloat = 135.0
        static let wheelIndicatorSpacing: CGFloat = 20.0
        static let days = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
		static let months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
		static let gender = ["Male","Female"]
        static let dayInitalValue = "2"
		static let genderInitalValue = "Male"
		static let monthInitalValue = "February"
        static let labelText = "Selected Values are: "
		static let comma = ", "
    }

	@IBOutlet weak var monthWheelHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var genderWheelHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var monthsWheelBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var genderWheelBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var monthsWheel: ModesoWheel!
	@IBOutlet weak var genderWheel: ModesoWheel!
	@IBOutlet weak var daysWheelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedValueLabel: UILabel!
    @IBOutlet weak var daysWheelHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var daysWheel: ModesoWheel!
    override func viewDidLoad() {
		super.viewDidLoad()
		self.daysWheel.delegate = self
		self.monthsWheel.delegate = self
		self.genderWheel.delegate = self
		self.daysWheel.configure(withData: Const.days, defaultValue: Const.dayInitalValue)
		self.monthsWheel.configure(withData: Const.months, defaultValue: Const.monthInitalValue)
		self.genderWheel.configure(withData: Const.gender, defaultValue: Const.genderInitalValue)
        self.selectedValueLabel.text = Const.labelText + Const.genderInitalValue + Const.comma + Const.monthInitalValue + Const.comma + Const.dayInitalValue
        dismissWheelWhenTappingAround()
	}
    
    func dismissWheelWhenTappingAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissWheel))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissWheel() {
        self.daysWheel.dismiss()
		self.monthsWheel.dismiss()
		self.genderWheel.dismiss()
    }
}
extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let isModesoWheel = touch.view?.superview?.superview?.superview?.superview?.isKind(of: ModesoWheel.self) else {
            return true
        }
        return !isModesoWheel
    }
}
extension ViewController: ModesoWheelDelegate {
    func resizeWheel(_ view: ModesoWheel, to height: CGFloat) {
		if view == self.daysWheel {
        	self.daysWheelHeightConstraint.constant = height
        	self.daysWheelBottomConstraint.constant = self.daysWheel.isExpanded ? Const.wheelBottomSpacing - Const.wheelIndicatorSpacing : Const.wheelBottomSpacing
		} else if view == self.monthsWheel {
			self.monthWheelHeightConstraint.constant = height
			self.monthsWheelBottomConstraint.constant = self.monthsWheel.isExpanded ? Const.wheelBottomSpacing - Const.wheelIndicatorSpacing : Const.wheelBottomSpacing
		} else {
			self.genderWheelHeightConstraint.constant = height
			self.genderWheelBottomConstraint.constant = self.genderWheel.isExpanded ? Const.wheelBottomSpacing - Const.wheelIndicatorSpacing : Const.wheelBottomSpacing
		}
    }
    
    func wheelTapped(_ view: ModesoWheel) {
		if view == self.genderWheel {
			self.monthsWheel.dismiss()
			self.daysWheel.dismiss()
		} else if view == self.monthsWheel {
			self.genderWheel.dismiss()
			self.daysWheel.dismiss()
		} else {
			self.monthsWheel.dismiss()
			self.genderWheel.dismiss()
		}
    }
    
    func wheelDidSelectValue(_ view: ModesoWheel) {
        self.selectedValueLabel.text = Const.labelText + self.genderWheel.getSelectedValue() + Const.comma + self.monthsWheel.getSelectedValue() + Const.comma + self.daysWheel.getSelectedValue()
    }
}
