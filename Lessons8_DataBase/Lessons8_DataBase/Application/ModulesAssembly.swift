//
//  ModulesAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 07.12.2020.
//

import UIKit

protocol IModulesAssembly {
	func createMainModule(coordinateController: ICoordinateController) -> UIViewController
}

final class ModulesAssembly: IModulesAssembly {
	private var model = TestModel()
	
	init() {
		model.setData(["Microsoft", "Apple"])
	}
	
	func createMainModule(coordinateController: ICoordinateController) -> UIViewController {
		let view = MainModuleAssemble.createMainModule(model: self.model, coordinateController: coordinateController)
		return view
	}
}

