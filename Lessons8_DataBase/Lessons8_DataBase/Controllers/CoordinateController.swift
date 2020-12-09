//
//  CoordinateController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 07.12.2020.
//

import UIKit

protocol ICoordinateController: class {
	func showEmployeesCompanyAt(companyID: UUID)
	func showEmployeeInfo(companyID: UUID, editMode: Bool)
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
		
	func showEmployeesCompanyAt(companyID: UUID) {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init showEmployeesList")
			return
		}
		let secondViewController = SecondModuleAssembly.createSecondModule(coordinateController: self, companyID: companyID)
		navigationController.pushViewController(secondViewController, animated: true)
	}

	func showEmployeeInfo(companyID: UUID, editMode: Bool) {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init showAddEmployeeList")
			return
		}
		let addEmployeeViewController = AddEmployeeModuleAssembly.createAddEmployeeModule(companyID: companyID, editMode: editMode)
		navigationController.pushViewController(addEmployeeViewController, animated: true)
	}
}
