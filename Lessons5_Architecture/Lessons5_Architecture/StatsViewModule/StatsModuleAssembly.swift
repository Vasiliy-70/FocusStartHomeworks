//
//  StatsModuleAssembly.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 03.12.2020.
//

import UIKit

enum StatsModuleAssembly {
	static func createStatsModule(coordinateController: ICoordinateController, model: Model) -> UIViewController {
		let view = StatsViewController()
		let presenter = StatsPresenter(viewController: view, model: model)
		view.presenter = presenter
		return view
	}
}
