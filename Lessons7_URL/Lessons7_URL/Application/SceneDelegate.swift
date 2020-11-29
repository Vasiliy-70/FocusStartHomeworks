//
//  SceneDelegate.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 29.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?


	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return assertionFailure() }
		self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		
		guard let window = self.window else {
			return assertionFailure()
		} 
		window.windowScene = windowScene
		
		let mainViewController = MainViewController()
		let navigationController = UINavigationController(rootViewController: mainViewController)
		
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
		
	}
}

