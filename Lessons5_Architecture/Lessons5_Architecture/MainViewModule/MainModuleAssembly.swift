//
//  MainModuleAssembly.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 02.12.2020.
//
import UIKit

enum MainModuleAssembly {
	static func createMainModule(coordinateController: ICoordinateController) -> UIViewController {
		let model = Model(minValue: 0, maxValue: 5)
		let view = MainViewController()
		let presenter = MainPresenter(coordinateController: coordinateController, viewController: view, model: model)
		view.presenter = presenter
		return view
	}
}
