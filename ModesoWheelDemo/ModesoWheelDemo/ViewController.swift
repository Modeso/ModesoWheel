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
        static let wheelBottomSpacing: CGFloat = 155.0
        static let wheelIndicatorSpacing: CGFloat = 20.0
        static let wheelData = ["1","2","3","4","5","6","7","8","9","10"]
        static let wheelInitalValue = "5"
        static let labelText = "Selected Value: "
    }

    @IBOutlet weak var wheelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedValueLabel: UILabel!
    @IBOutlet weak var wheelHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var wheel: ModesoWheel!
    override func viewDidLoad() {
		super.viewDidLoad()
		self.wheel.configure(withData: Const.wheelData, defaultValue: Const.wheelInitalValue)
		self.wheel.delegate = self
        self.selectedValueLabel.text = Const.labelText + Const.wheelInitalValue
        dismissWheelWhenTappingAround()
	}
    
    func dismissWheelWhenTappingAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissWheel))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissWheel() {
        self.wheel.dismiss()
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
        self.wheelHeightConstraint.constant = height
        self.wheelBottomConstraint.constant = self.wheelBottomConstraint.constant == Const.wheelBottomSpacing ? Const.wheelBottomSpacing - Const.wheelIndicatorSpacing : Const.wheelBottomSpacing
    }
    
    func wheelTapped(_ view: ModesoWheel) {
        self.selectedValueLabel.text = Const.labelText + self.wheel.getSelectedValue()
    }
    
    func wheelDidSelectValue(_ view: ModesoWheel) {
        self.selectedValueLabel.text = Const.labelText + self.wheel.getSelectedValue()
    }
}
