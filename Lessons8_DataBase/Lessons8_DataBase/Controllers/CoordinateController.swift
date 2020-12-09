//
//  CoordinateController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 07.12.2020.
//

import UIKit

protocol ICoordinateController: class {
	func showEmployeesList()
	func showAddEmployeeList()
}

final class CoordinateController: ICoordinateController {
	private var navigationController: UINavigationController?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func initialStartViewController() {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init start vc"); return
		}
		let mainViewController = MainModuleAssembly.createMainModule(coordinateController: self)
		navigationController.viewControllers = [mainViewController]
	}
	
	func showEmployeesList() {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init showEmployeesList")
			return
		}
		let secondViewController = SecondModuleAssembly.createSecondModule(coordinateController: self)
		navigationController.pushViewController(secondViewController, animated: true)
	}
	
	func showAddEmployeeList() {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init showAddEmployeeList")
			return
		}
		let addEmployeeViewController = AddEmployeeModuleAssembly.createAddEmployeeModule()
		navigationController.pushViewController(addEmployeeViewController, animated: true)
	}
}
