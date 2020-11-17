//
//  SceneDelegate.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private let coordinatingController = CoordinateController()
	private lazy var flowController = FlowController(coordinationController: self.coordinatingController)
	private lazy var nc: UINavigationController = {
		UINavigationController(rootViewController: self.flowController.firstVC)
	}()
	

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return assertionFailure() }
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		
		guard let window = window else { return assertionFailure() }
		window.windowScene = windowScene
		
	//	let firstViewController = ModuleAssembly.createMainModule()
		//let secondViewController = ModuleAssembly.createStatsModule()
	
		//let secondViewController = ModuleAssembly.createStatsModule()
		
		//firstViewController.title = "FirstScreen"
		//secondViewController.title = "SecondScreen"
		
		//let firstViewNavigationController = UINavigationController(rootViewController: firstViewController)
		//let secondViewNavigationController = UINavigationController(rootViewController: secondViewController)
		//let thirdViewNavigationController = UINavigationController(rootViewController: thirdViewController)

		//let tabBar = UITabBarController()
		//tabBar.setViewControllers([firstViewNavigationController, secondViewNavigationController], animated: true)
		
		self.window = UIWindow(windowScene: windowScene)
		self.window?.rootViewController = self.nc
		self.window?.makeKeyAndVisible()
	}
}

