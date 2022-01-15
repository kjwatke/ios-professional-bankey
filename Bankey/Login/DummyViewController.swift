//
//  DummyViewController.swift
//  Bankey
//
//  Created by Kevin  Watke on 1/14/22.
//

import Foundation
import UIKit

class DummyViewController: UIViewController {
	
	let stackView = UIStackView()
	let label = UILabel()
	let logoutButton = UIButton(type: .system)
	
	weak var logoutDelgate: LogoutDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		style()
		layout()
	}
}

extension DummyViewController {
	
	private func style() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 20
		
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Welcome"
		label.font = UIFont.preferredFont(forTextStyle: .title3)
		
		logoutButton.translatesAutoresizingMaskIntoConstraints = false
		logoutButton.configuration = .filled()
		logoutButton.setTitle("Logout", for: [])
		logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
	}
	
	private func layout() {
		stackView.addArrangedSubview(label)
		stackView.addArrangedSubview(logoutButton)
		
		view.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
	@objc func logoutButtonTapped(_ sender: UIButton) {
		logoutDelgate?.didLogout()
	}
}
