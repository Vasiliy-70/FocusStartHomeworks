//
//  SceneDelegate.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 19.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = scene as? UIWindowScene else { return assertionFailure() }
		self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		
		guard let window = self.window else {
			return assertionFailure()
		}
		
		window.windowScene = windowScene
		
		let uiConstructor = UIConstructor()
		let builder = Builder()
		uiConstructor.update(builder: builder)

		uiConstructor.buildUI(elements: [.button, .label, .image, .button, .image, .button, .label], backgroundColor: .red)
		let firstViewController = builder.retrieveViewController()
		
		uiConstructor.buildUI(elements: [.label, .image, .label], backgroundColor: .blue)
		let secondViewController = builder.retrieveViewController()
		
		let thirdViewController = EventsViewController()

		firstViewController.title = "FirstScreen"
		secondViewController.title = "SecondScreen"
		thirdViewController.title = "EventsView"
		
		let firstViewNavigationController = UINavigationController(rootViewController: firstViewController)
		let secondViewNavigationController = UINavigationController(rootViewController: secondViewController)
		let thirdViewNavigationController = UINavigationController(rootViewController: thirdViewController)

		let tabBar = UITabBarController()
		tabBar.setViewControllers([firstViewNavigationController, secondViewNavigationController, thirdViewNavigationController], animated: true)
		
		window.rootViewController = tabBar
		window.makeKeyAndVisible()
	}
}

