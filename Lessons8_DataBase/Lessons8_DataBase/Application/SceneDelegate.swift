//
//  SceneDelegate.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		
		guard let window = self.window else { assertionFailure("No window"); return}
		window.windowScene = windowScene
		
		let navigationController = UINavigationController()
		let coordinateController = CoordinateController(navigationController: navigationController)
		coordinateController.initialStartViewController()
		
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}

