//
//  AddEmployeeModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

enum AddEmployeeModuleAssembly {
	static func createAddEmployeeModule(companyID: UUID, editMode: Bool) -> UIViewController {
		let view = AddEmployeeViewController(editMode: editMode)
		let presenter = AddEmployeePresenter(view: view, companyID: companyID)
		view.presenter = presenter
		return view
	}
}
