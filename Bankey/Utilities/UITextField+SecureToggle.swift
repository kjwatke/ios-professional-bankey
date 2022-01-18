//
//  UITextField+SecureToggle.swift
//  Bankey
//
//  Created by Kevin  Watke on 1/18/22.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
	func enablePasswordToggle() {
		passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
		passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
		passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
		rightView = passwordToggleButton
		rightViewMode = .always
	}
	
	@objc func togglePasswordView() {
		isSecureTextEntry.toggle()
		passwordToggleButton.isSelected.toggle()
	}
}
