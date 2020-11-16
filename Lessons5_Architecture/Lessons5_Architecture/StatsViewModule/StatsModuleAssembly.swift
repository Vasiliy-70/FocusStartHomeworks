//
//  StatsModuleAssembly.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//

import UIKit

struct StatsModuleAssembly {
	let model = Model(minValue: 0, maxValue: 10, previousValue: [])
	
	static func createMainModule() -> UIViewController {
		let view = MainViewController()
		
		let presenter = MainPresenter(viewController: view, model: model)
		view.presenter = presenter
		return view
	}
}
