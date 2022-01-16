//
//  AccountSummaryHeaderView.swift
//  Bankey
//
//  Created by Kevin  Watke on 1/16/22.
//

import UIKit

class AccountSummaryHeaderView: UIView {
	
	@IBOutlet var contentView: UIView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	
	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIView.noIntrinsicMetric, height: 144)
	}
	
	
	private func commonInit() {
		let bundle = Bundle(for: AccountSummaryViewController.self)
		bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
		addSubview(contentView)
		contentView.backgroundColor = appColor
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
	}
}
