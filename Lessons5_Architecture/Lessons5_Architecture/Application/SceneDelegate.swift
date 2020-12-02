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
		
		let navigationController = UINavigationController()
		let coordinateController = CoordinateController(navigationController: navigationController, moduleAssembly: ModuleAssembly())
		coordinateController.initialViewController()
		
		
		self.window = UIWindow(windowScene: windowScene)
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
	}
}

