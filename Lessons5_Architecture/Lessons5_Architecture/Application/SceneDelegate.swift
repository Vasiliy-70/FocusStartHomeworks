//
//  SceneDelegate.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return assertionFailure() }
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		
		guard let window = window else { return assertionFailure() }
		window.windowScene = windowScene
		
		let firstViewController = ModuleAssembly.createMainModule()
		let secondViewController = ModuleAssembly.createStatsModule()
		
		firstViewController.title = "FirstScreen"
		secondViewController.title = "SecondScreen"
		
		let firstViewNavigationController = UINavigationController(rootViewController: firstViewController)
		let secondViewNavigationController = UINavigationController(rootViewController: secondViewController)
		//let thirdViewNavigationController = UINavigationController(rootViewController: thirdViewController)

		let tabBar = UITabBarController()
		tabBar.setViewControllers([firstViewNavigationController, secondViewNavigationController], animated: true)
		
		window.rootViewController = tabBar
		window.makeKeyAndVisible()
	}
}

