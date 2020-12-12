//
//  CoordinateController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 07.12.2020.
//

import UIKit

enum EmployeeInfoMode {
	case editing
	case addition
	case showing
}

protocol ICoordinateController: class {
	func showEmployeesCompanyAt(companyID: UUID)
	func showEmployeeInfo(employeeID: UUID?, companyID: UUID, editMode: EmployeeInfoMode)
}

final class CoordinateController: ICoordinateController {
	private var navigationController: UINavigationController?
	private var queryModel = ModelQueryService()
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func initialStartViewController() {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init start vc")
			return
		}
		let mainViewController = MainModuleAssembly.createMainModule(coordinateController: self, queryModel: self.queryModel)
		navigationController.viewControllers = [mainViewController]
	}
		
	func showEmployeesCompanyAt(companyID: UUID) {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init showEmployeesList")
			return
		}
		let secondViewController = SecondModuleAssembly.createSecondModule(coordinateController: self, queryModel: self.queryModel, companyID: companyID)
		navigationController.pushViewController(secondViewController, animated: true)
	}

	func showEmployeeInfo(employeeID: UUID?, companyID: UUID, editMode: EmployeeInfoMode) {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init showAddEmployeeList")
			return
		}
		let addEmployeeViewController = EmployeeInfoModuleAssembly.createAddEmployeeModule(queryModel: self.queryModel, companyID: companyID, employeeID: employeeID, editMode: editMode)
		navigationController.pushViewController(addEmployeeViewController, animated: true)
	}
}
