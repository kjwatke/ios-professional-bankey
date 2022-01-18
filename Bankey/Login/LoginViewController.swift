//
//  ViewController.swift
//  Bankey
//
//  Created by Kevin  Watke on 1/9/22.
//

import UIKit

protocol LogoutDelegate: AnyObject {
	func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
	func didLogin()
}

class LoginViewController: UIViewController {

	let titleLabel = UILabel()
	let subtitleLabel = UILabel()
	
	let loginView = LoginView()
	let signInButton = UIButton(type: .system)
	let errorMessageLabel = UILabel()
	
	weak var delegate: LoginViewControllerDelegate?
	
	var username: String? {
		return loginView.userNameTextField.text
	}
	
	var password: String? {
		return loginView.passwordTextField.text
	}
	
	// animation
	var leadingEdgeOnScreen: CGFloat = 16
	var leadingEdgeOffScreen: CGFloat = -1000
	
	var titleLeadingAnchor: NSLayoutConstraint?
	var subtitleLeadingAnchor: NSLayoutConstraint?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		style()
		layout()
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		animate()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		signInButton.configuration?.showsActivityIndicator = false
	}
}

extension LoginViewController {
	
	func style() {
		view.backgroundColor = .systemBackground
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textAlignment = .center
		titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		titleLabel.adjustsFontForContentSizeCategory = true
		titleLabel.text = "Bankey"
		
		subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
		subtitleLabel.textAlignment = .center
		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
		subtitleLabel.adjustsFontForContentSizeCategory = true
		subtitleLabel.numberOfLines = 0
		subtitleLabel.text = "Your premium source for all things banking!"
		
		loginView.translatesAutoresizingMaskIntoConstraints = false
		
		signInButton.translatesAutoresizingMaskIntoConstraints = false
		signInButton.configuration = .filled()
		signInButton.configuration?.imagePadding = 8
		signInButton.setTitle("Sign In", for: [])
		signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
		
		errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
		errorMessageLabel.textAlignment = .center
		errorMessageLabel.textColor = .systemRed
		errorMessageLabel.numberOfLines = 0
		errorMessageLabel.text = "Fake error text"
		errorMessageLabel.isHidden = true
		
	}
	
	
	func layout() {
		view.addSubview(titleLabel)
		view.addSubview(subtitleLabel)
		view.addSubview(loginView)
		view.addSubview(signInButton)
		view.addSubview(errorMessageLabel)
		
		// titleLabel
		NSLayoutConstraint.activate([
			subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
			titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
		])
		
		titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
		titleLeadingAnchor?.isActive = true
		
		// subtitleLabel
		NSLayoutConstraint.activate([
			loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
//			subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
			subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
		])
		
		subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
		subtitleLeadingAnchor?.isActive = true
		
		// LoginView
		NSLayoutConstraint.activate([
			loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
		])
		
		// Login Button
		NSLayoutConstraint.activate([
			signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
			signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
			signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
		])
		
		// Error Label
		NSLayoutConstraint.activate([
			errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
			errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
			errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
		])
	}
}

	// MARK: - Actions

extension LoginViewController {
	
	@objc func signInTapped(_ sender: UIButton) {
		errorMessageLabel.isHidden = true
		login()
	}
	
	private func login() {
		guard let username = username, let password = password else {
			assertionFailure("Username and Password cannot be nil")
			return
		}
		
		if username.isEmpty || password.isEmpty {
			configureView(withMessage: "Username / password cannot be blank")
			return
		}
		
		if username == "Flynn" && password == "Welcome" {
			signInButton.configuration?.showsActivityIndicator = true
			delegate?.didLogin()
		} else {
			configureView(withMessage: "Incorrect username / password")
		}
		
	}
	
	
	private func configureView(withMessage message: String) {
		errorMessageLabel.isHidden = false
		errorMessageLabel.text = message
		shakeButton()
	}
}

// MARK: - Animations

extension LoginViewController {
	private func animate() {
		let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
			self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
			self.view.layoutIfNeeded()
		}
		animator1.startAnimation()
		
		let animator2 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
			self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
			self.view.layoutIfNeeded()
		}
		animator2.startAnimation(afterDelay: 1)
	}
	
	private func shakeButton() {
		let animation = CAKeyframeAnimation()
		animation.keyPath = "position.x"
		animation.values = [0, 10, -10, 10, 0]
		animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
		animation.duration = 0.4
		
		animation.isAdditive = true
		signInButton.layer.add(animation, forKey: "shake")
	}
}

