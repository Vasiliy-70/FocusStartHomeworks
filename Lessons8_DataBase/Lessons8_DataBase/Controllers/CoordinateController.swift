//
//  CoordinateController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 07.12.2020.
//

import UIKit

protocol ICoordinateController {
}

final class CoordinateController: ICoordinateController {
	private var navigationController: UINavigationController?
	private var modulesAssembly: IModulesAssembly?
	
	init(navigationController: UINavigationController, modulesAssembly: IModulesAssembly) {
		self.navigationController = navigationController
		self.modulesAssembly = modulesAssembly
	}
	
	func initialStartViewController() {
		guard let navigationController = self.navigationController,
			  let mainViewController = self.modulesAssembly?.createMainModule(coordinateController: self) else {
			assertionFailure("Error init start vc"); return
		}
		navigationController.viewControllers = [mainViewController]
	}
}
