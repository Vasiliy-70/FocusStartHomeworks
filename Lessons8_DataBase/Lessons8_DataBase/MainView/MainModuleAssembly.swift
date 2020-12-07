//
//  MainModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import UIKit

enum MainModuleAssemble {
	static func createMainModule(model: TestModel, coordinateController: ICoordinateController) -> UIViewController {
		let model = model
		let view = MainViewController()
		let presenter = MainPresenter(view: view, model: model, coordinateController: coordinateController)
		view.presenter = presenter
		return view
	}
}
