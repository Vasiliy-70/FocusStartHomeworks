//
//  ModuleAssembly.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

protocol IModuleAssembly {
	func createMainModule(coordinateController: ICoordinateController) -> UIViewController
	func createStatsModule(coordinateController: ICoordinateController) -> UIViewController
}

final class ModuleAssembly: IModuleAssembly {
	var model = Model(minValue: 0, maxValue: 5)
	
	func createMainModule(coordinateController: ICoordinateController) -> UIViewController {
		MainModuleAssembly.createMainModule(coordinateController: coordinateController, model: model)
	}
	
	func createStatsModule(coordinateController: ICoordinateController) -> UIViewController {
		StatsModuleAssembly.createStatsModule(coordinateController: coordinateController, model: model)
	}
}

