//
//  ModesoWheel.swift
//  Break Even
//
//  Created by Esraa Yasser on 1/30/18.
//  Copyright © 2018 Modeso. All rights reserved.
//

import UIKit

@objc public protocol ModesoWheelDelegate {
    /**
     This method called when open and dismiss the wheel to resize the container
     view to the current size to be able to select and scroll rows
     */
    func resizeWheel(_ view: ModesoWheel, to height: CGFloat)
    /**
     This method called when tap on the wheel did become active
     */
    func wheelTapped(_ view: ModesoWheel)
    /**
     This method called when selected value changed
     */
    func wheelDidSelectValue(_ view: ModesoWheel)
}

@IBDesignable public class ModesoWheel: UIView {
	
	enum Const {
		static let titleHeight: CGFloat = 25.0
		static let rowHeight: CGFloat = 45.0
		static let separatorHeight: CGFloat = 1.0
		static let tableViewCellIdentifier = "tableViewCellIdentifier"
	}
    
    // MARK: - IBInspectable Elements
    @IBInspectable public var title: String {
        get {
            return self.titleText
        }
        set(value) {
            self.titleText = value
        }
    }
    
    @IBInspectable public var defaultValue: String? {
        get {
            return currentSelectedValue
        }
        set(inputText) {
            currentSelectedValue = inputText
        }
    }
    
    @IBInspectable public var optionsBackgroundColor: UIColor {
        get {
            return self.bgColor
        }
        set(color) {
            self.bgColor = color
        }
    }
    
    @IBInspectable public var selectColor: UIColor {
        get {
            return self.separatorColor
        }
        set(color) {
            self.separatorColor = color
            self.separatorView?.backgroundColor = color
        }
    }
	
	@IBInspectable public var optionsColor: UIColor {
		get {
			return self.optionsTextColor
		}
		set(color) {
			self.optionsTextColor = color
		}
	}
	@IBInspectable public var titleColor: UIColor {
		get {
			return self.titleTextColor
		}
		set(color) {
			self.titleTextColor = color
		}
	}
	@IBInspectable public var titleFont: UIFont {
		get {
			return self.titleTextFont
		}
		set(font) {
			self.titleTextFont = font
		}
	}
	@IBInspectable public var optionsFont: UIFont {
		get {
			return self.optionsTextFont
		}
		set(font) {
			self.optionsTextFont = font
		}
	}
	@IBInspectable public var optionsHeight: CGFloat {
		get {
			return self.rowHeight
		}
		set(value) {
			self.rowHeight = value
		}
	}
    
	var wheelData = [String]()
	var separatorColor: UIColor = UIColor.mbeCoolBlue
	var optionsTextColor: UIColor = UIColor.mbeSteel
    public weak var delegate: ModesoWheelDelegate?
    // MARK: - Private Variables
    private var currentSelectedValue: String?
    private var titleText: String = ""
	private var titleTextColor: UIColor = UIColor.mbeSteel
    private var rowHeight: CGFloat = Const.rowHeight
    private var bgColor: UIColor = UIColor.mbeWhiteTwo
	private var titlebgColor: UIColor = UIColor.white
	public var isExpanded = false
	private var titleTextFont: UIFont = UIFont.mbeRegular15Font()
	private var optionsTextFont: UIFont = UIFont.mbeMedium36Font()
    
    // MARK: - Outlets
	@IBOutlet weak var valueLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var separatorViewBottomConstraint: NSLayoutConstraint!
    // MARK: - Init
	required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		self.loadFromNib()
		self.tableView?.register(WheelTableViewCell.classForCoder(), forCellReuseIdentifier: Const.tableViewCellIdentifier)
		self.tableView?.delegate = self
    }
    
	override public func draw(_ rect: CGRect) {
        setupUIText()
		setupColors()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandTableView(_:))))
        self.isUserInteractionEnabled = true
    }
    
    public func configure(withData data: [String], defaultValue: String) {
        self.titleLabel.attributedText = Utilities.attributedText(title ?? "", font: self.titleTextFont, letterSpacing: UIFont.LetterSpacing.narrow, color: self.titleTextColor)
        self.wheelData = data
        currentSelectedValue = defaultValue
        self.tableView.reloadData()
		if let index = data.index(of: currentSelectedValue ?? "") {
        	self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .middle)
		}
		self.valueLabel.attributedText = Utilities.attributedText(defaultValue, font: self.optionsTextFont, letterSpacing: UIFont.LetterSpacing.narrow, color: self.separatorColor)
		self.valueLabel.isHidden = false
		self.tableView.isHidden = true
		self.delegate?.resizeWheel(self, to: self.rowHeight + Const.titleHeight + Const.separatorHeight)
    }
	public func dismiss() {
		if isExpanded {
			isExpanded = false
			if let index = self.wheelData.index(of: self.getSelectedValue()) {
				self.tableView.scrollToRow(at: IndexPath(row: index + 1, section: 0), at: .middle, animated: false)
			}
			self.tableViewBottomConstraint.constant = Const.titleHeight
			self.separatorViewBottomConstraint.constant = Const.titleHeight
			self.delegate?.resizeWheel(self, to: Const.titleHeight + self.rowHeight + Const.separatorHeight)
			self.valueLabel.attributedText = Utilities.attributedText(self.getSelectedValue(), font: self.optionsTextFont, letterSpacing: UIFont.LetterSpacing.narrow, color: self.separatorColor)
			self.valueLabel.isHidden = false
			self.tableView.isHidden = true
			self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandTableView(_:))))
			self.isUserInteractionEnabled = true
		}
	}
	public func getSelectedValue() -> String {
		return currentSelectedValue ?? ""
	}
	func setSelectedValue(_ value: String) {
		self.updateSelectedValue(value)
		self.unHighlightAllCells()
		if let index = wheelData.index(of: currentSelectedValue ?? "") {
			let indexPath = IndexPath(row: index + 1, section: 0)
			guard let cell = tableView.cellForRow(at: indexPath) as? WheelTableViewCell else {
				return
			}
			if indexPath.row > 0 && indexPath.row <= self.wheelData.count {
				let text = self.wheelData[indexPath.row - 1]
				cell.setText(text, isSelected: true)
			}
			self.tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: false)
		}
	}
    
    // MARK: - Private Methods
	private func setupColors() {
		self.titleLabel.backgroundColor = self.titlebgColor
		self.valueLabel.backgroundColor = self.bgColor
		self.separatorView.backgroundColor = self.separatorColor
	}
	private func updateSelectedValue(_ value: String) {
		currentSelectedValue = value
		self.valueLabel.attributedText = Utilities.attributedText(value, font: self.optionsTextFont, letterSpacing: UIFont.LetterSpacing.narrow, color: self.separatorColor)
	}
    private func setupUIText() {
        titleLabel?.attributedText = Utilities.attributedText(titleLabel.text ?? "", font: self.titleTextFont, letterSpacing: UIFont.LetterSpacing.narrow, color: self.titleTextColor)
    }
    @objc private func expandTableView(_ sender: UITapGestureRecognizer) {
		if !isExpanded && wheelData.count>0 {
        	self.tableViewBottomConstraint.constant = 0
        	self.separatorViewBottomConstraint.constant = rowHeight
        	self.tableView.isScrollEnabled = true
			self.valueLabel.isHidden = true
			self.tableView.isHidden = false
        	self.isExpanded = true
        	self.delegate?.resizeWheel(self, to: CGFloat(rowHeight * 3))
			self.delegate?.wheelTapped(self)
			if let index = wheelData.index(of: currentSelectedValue ?? "") {
				self.tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .middle, animated: false)
			}
			self.gestureRecognizers?.removeAll()
		}
    }
	private func unHighlightAllCells() {
		for cell in tableView.visibleCells {
			guard let wheelCell = cell as? WheelTableViewCell else {
				break
			}
			let index = tableView.indexPath(for: wheelCell)?.row ?? 1
			if index > 0 && index <= self.wheelData.count {
				let text = self.wheelData[index - 1]
				wheelCell.setText(text, isSelected: false)
			}
		}
	}
    
}
// MARK: - TableView DataSource
extension ModesoWheel: UITableViewDataSource {
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.tableViewCellIdentifier, for: indexPath) as? WheelTableViewCell else {
			return WheelTableViewCell()
		}
        guard indexPath.row > 0, indexPath.row <= wheelData.count else {
			cell.configureStyle(withHeight: self.rowHeight, backgroundColor: self.titlebgColor, selectColor: self.separatorColor, defaultColor: self.optionsTextColor, font: self.optionsTextFont)

			cell.setText(nil, isSelected: false)
            return cell
        }
		cell.configureStyle(withHeight: self.rowHeight, backgroundColor: self.bgColor, selectColor: self.separatorColor, defaultColor: self.optionsTextColor, font: self.optionsTextFont)
		let isSelected = ((self.wheelData.index(of: self.getSelectedValue()) ?? 0) + 1) == indexPath.row
        let text = self.wheelData[indexPath.row - 1]
        
		cell.setText(text, isSelected: isSelected)
        return cell
    }
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.wheelData.count > 0 else {
            return 0
        }
        return self.wheelData.count + 2
    }
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return self.rowHeight
	}
}
// MARK: - TableView Delegate
extension ModesoWheel: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard indexPath.row > 0, indexPath.row <= self.wheelData.count, indexPath.row != ((self.wheelData.index(of: self.getSelectedValue()) ?? 0) + 1) else {
			self.dismiss()
			return
		}
       self.unHighlightAllCells()
		guard let cell = tableView.cellForRow(at: indexPath) as? WheelTableViewCell else {
			return
		}
		if indexPath.row > 0 && indexPath.row <= self.wheelData.count {
			let text = self.wheelData[indexPath.row - 1]
			cell.setText(text, isSelected: true)
			self.updateSelectedValue(text)
			self.delegate?.wheelDidSelectValue(self)
		}
        
		tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}
extension ModesoWheel: UIScrollViewDelegate {
	
	// MARK: UIScrollViewDelegate
	
	public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let partialRow = Float(targetContentOffset.pointee.y / rowHeight) // Get the estimative of what row will be the selected when the scroll animation ends.
		var roundedRow = Int(lroundf(partialRow)) // Round the estimative to a row
		
		if roundedRow < 0 {
			roundedRow = 0
		} else {
			targetContentOffset.pointee.y = CGFloat(roundedRow) * rowHeight // Set the targetContentOffset (where the scrolling position will be when the animation ends) to a rounded value.
		}
		if let cellToHighlight = tableView.cellForRow(at: IndexPath(row: roundedRow, section: 0)) as? WheelTableViewCell {
			if roundedRow > 0 && roundedRow <= self.wheelData.count {
				let text = self.wheelData[roundedRow - 1]
				cellToHighlight.setText(text, isSelected: true)
				self.updateSelectedValue(text)
				self.delegate?.wheelDidSelectValue(self)
			}
		}
	}
	
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
 		guard let indexs = tableView.indexPathsForVisibleRows, indexs.count > 2 else {
			return
		}
		let indexOFHighletedCell = indexs[1] 
		// Avoid to have two highlighted rows at the same time
		if let visibleRows = tableView.indexPathsForVisibleRows {
			for indexPath in visibleRows {
				if let cellToUnhighlight = tableView.cellForRow(at: indexPath) as? WheelTableViewCell, (indexPath as NSIndexPath).row != indexOFHighletedCell.row {
					if indexPath.row > 0 && indexPath.row <= self.wheelData.count {
						let text = self.wheelData[indexPath.row - 1]
						cellToUnhighlight.setText(text, isSelected: false)
					}
				}
			}
		}
		
		// Highlight the current selected cell during scroll
		if let cellToHighlight = tableView.cellForRow(at: indexOFHighletedCell) as? WheelTableViewCell {
			if indexOFHighletedCell.row > 0 && indexOFHighletedCell.row <= self.wheelData.count {
				let text = self.wheelData[indexOFHighletedCell.row - 1]
				cellToHighlight.setText(text, isSelected: true)
				self.updateSelectedValue(text)
				self.delegate?.wheelDidSelectValue(self)
			}
		}
	}
}
