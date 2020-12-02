//
//  MainModuleAssembly.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 02.12.2020.
//
import UIKit

enum MainModuleAssembly {
	static func createMainModule(coordinateController: ICoordinateController, model: Model) -> UIViewController {
		let view = MainViewController()
		let presenter = MainPresenter(coordinateController: coordinateController, viewController: view, model: model)
		view.presenter = presenter
		return view
	}
}
