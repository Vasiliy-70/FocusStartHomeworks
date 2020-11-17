//
//  ModuleAssembly.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

enum ModuleAssembly {
	static let model = Model(minValue: 0, maxValue: 10, previousValue: [])
	static func createMainModule(coordinateController: CoordinateController) -> UIViewController {
		let view = MainViewController()
		let presenter = MainPresenter(coordinateController: coordinateController, viewController: view, model: model)
		view.presenter = presenter
		return view
	}
	
	static func createStatsModule(coordinateController: CoordinateController) -> UIViewController {
		let view = StatsViewController()
		let presenter = StatsPresenter(viewController: view, model: model)
		view.presenter = presenter
		return view
	}
}

