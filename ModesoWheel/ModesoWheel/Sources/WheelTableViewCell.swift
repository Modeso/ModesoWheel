//
//  WheelTableViewCell.swift
//  ModesoWheel
//
//  Created by Esraa Yasser on 2/22/18.
//

import UIKit

 class WheelTableViewCell: UITableViewCell {
	lazy var titleLabel: UILabel = {
		let titleLabel = UILabel(frame: self.contentView.bounds)
		titleLabel.textAlignment = .center
		
		return titleLabel
	}()
	
	private var height: CGFloat = 0.0
	private var cellBackgroundColor: UIColor = UIColor.white
	private var selectColor: UIColor = UIColor.coolBlue
	private var defaultColor: UIColor = UIColor.steel
	private var textFont: UIFont = UIFont.wheelOptionsFont()
	
	func configureStyle(withHeight height: CGFloat, backgroundColor: UIColor, selectColor: UIColor, defaultColor: UIColor, font: UIFont) {
		self.height = height
		self.cellBackgroundColor = backgroundColor
		self.selectColor = selectColor
		self.defaultColor = defaultColor
		self.textFont = font
		self.selectionStyle = .none
		self.backgroundColor = self.cellBackgroundColor
	}
	
	func setText(_ title: String?, isSelected: Bool) {
		DispatchQueue.main.async {
			self.titleLabel.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.height)
			self.contentView.addSubview(self.titleLabel)
			guard let text = title else {
				self.titleLabel.text = ""
				return
			}
			self.titleLabel.attributedText = Utilities.attributedText(text, font: self.textFont, letterSpacing: UIFont.LetterSpacing.narrow, color: isSelected ? self.selectColor : self.defaultColor)
		}
	}
}
