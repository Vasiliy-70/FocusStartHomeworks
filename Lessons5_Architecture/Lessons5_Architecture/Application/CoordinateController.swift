//
//  CoordinateController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//

import UIKit
	
protocol ICoordinateController: class {
	func initialViewController()
	func showStatistics()
	var navigationController: UINavigationController? { get set }
	var moduleAssembly: IModuleAssembly? { get set }
}

final class CoordinateController {
	var navigationController: UINavigationController?
	var moduleAssembly: IModuleAssembly?
	
	init(navigationController: UINavigationController, moduleAssembly: IModuleAssembly) {
		self.navigationController = navigationController
		self.moduleAssembly = moduleAssembly
	}
}

extension CoordinateController: ICoordinateController {
	func initialViewController() {
		guard let navigationController = self.navigationController,
			  let mainViewController = self.moduleAssembly?.createMainModule(coordinateController: self) else { assertionFailure("Error in initial mainViewController"); return }
		navigationController.viewControllers = [mainViewController]
	}
	
	func showStatistics() {
		guard let navigationController = self.navigationController,
			  let statsViewController = self.moduleAssembly?.createStatsModule(coordinateController: self) else { assertionFailure("Error in creating of statsViewController"); return }
		navigationController.pushViewController(statsViewController, animated: true)
	}
	
	
}
