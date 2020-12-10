//
//  CoordinateController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//

import UIKit
	
protocol ICoordinateController: class {
	func initialViewController()
	func showStatisticsAt(model: Model)
	var navigationController: UINavigationController? { get set }
}

final class CoordinateController {
	var navigationController: UINavigationController?

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension CoordinateController: ICoordinateController {
	func initialViewController() {
		guard let navigationController = self.navigationController else {
			assertionFailure("Error in initial mainViewController")
			return
		}
		let mainViewController = MainModuleAssembly.createMainModule(
			coordinateController: self)
		navigationController.viewControllers = [mainViewController]
	}
	
	func showStatisticsAt(model: Model) {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error in creating of statsViewController")
			return
		}
		let statsViewController = StatsModuleAssembly.createStatsModule(
			coordinateController: self, model: model)
		navigationController.pushViewController(statsViewController, animated: true)
	}
}
