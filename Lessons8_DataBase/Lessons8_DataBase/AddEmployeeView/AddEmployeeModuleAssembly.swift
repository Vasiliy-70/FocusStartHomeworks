//
//  AddEmployeeModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

enum AddEmployeeModuleAssembly {
	static func createAddEmployeeModule() -> UIViewController {
		let view = AddEmployeeViewController()
		let presenter = AddEmployeePresenter(view: view)
		view.presenter = presenter
		return view
	}
}
