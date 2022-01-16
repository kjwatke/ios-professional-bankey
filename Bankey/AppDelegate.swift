//
//  AppDelegate.swift
//  Bankey
//
//  Created by Kevin  Watke on 1/9/22.
//

import UIKit

let appColor: UIColor = .systemTeal
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	let loginViewController = LoginViewController()
	let onboardingViewController = OnboardingContainerViewController()
	let dummyViewController = DummyViewController()
	let mainViewController = MainViewController()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		window?.backgroundColor = .systemBackground
		
		
		loginViewController.delegate = self
		onboardingViewController.delegate = self
		dummyViewController.logoutDelgate = self
		
		window?.rootViewController = mainViewController
	
		
		return true
	}
}

extension AppDelegate {
	func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
		guard animated, let window = self.window else {
			self.window?.rootViewController = vc
			self.window?.makeKeyAndVisible()
			return
		}
		
		window.rootViewController = vc
		window.makeKeyAndVisible()
		UIView.transition(with: window,
						  duration: 0.3,
						  options: .transitionCrossDissolve,
						  animations: nil,
						  completion: nil)
	}
}


extension AppDelegate: LoginViewControllerDelegate {
	func didLogin() {
		if LocalState.hasOnboarded {
			setRootViewController(dummyViewController)
		} else {
			setRootViewController(onboardingViewController)
		}
	}
}


extension AppDelegate: OnboardingContainerViewControllerDelegate {
	func didFinishOnboarding() {
		LocalState.hasOnboarded = true
		setRootViewController(dummyViewController)
	}
}

extension AppDelegate: LogoutDelegate {
	func didLogout() {
		setRootViewController(loginViewController)
	}
}


