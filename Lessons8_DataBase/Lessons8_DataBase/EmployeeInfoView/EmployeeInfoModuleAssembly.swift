//
//  EmployeeInfoModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

enum EmployeeInfoModuleAssembly {
	static func createAddEmployeeModule(companyID: UUID, employeeID: UUID?, editMode: EmployeeInfoMode) -> UIViewController {
		let view = EmployeeInfoViewController(editMode: editMode)
		let presenter = EmployeeInfoPresenter(view: view, companyID: companyID, employeeID: employeeID)
		view.presenter = presenter
		return view
	}
}
