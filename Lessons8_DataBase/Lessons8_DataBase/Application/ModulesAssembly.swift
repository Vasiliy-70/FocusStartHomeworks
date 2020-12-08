//
//  ModulesAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 07.12.2020.
//

import UIKit

protocol IModulesAssembly: class {
	func createMainModule(coordinateController: ICoordinateController) -> UIViewController
	func createDetailModule(coordinateController: ICoordinateController) -> UIViewController
}

final class ModulesAssembly: IModulesAssembly {
	private var queryModel = ModelQueryService()
	
	func createMainModule(coordinateController: ICoordinateController) -> UIViewController {
		let view = MainModuleAssemble.createMainModule(queryModel: self.queryModel, coordinateController: coordinateController)
		return view
	}
	
	func createDetailModule(coordinateController: ICoordinateController) -> UIViewController {
		//let view = SecondModuleAssembly.createDetailModule(model: self.model, coordinateController: coordinateController)
		//return view
		return UIViewController()
	}
}

