//
//  SecondModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

enum SecondModuleAssembly {
	static func createDetailModule(model: TestModel, coordinateController: ICoordinateController) -> UIViewController {
		let model = model
		let view = SecondViewController()
		let presenter = SecondPresenter(view: view, model: model, coordinateController: coordinateController)
		view.presenter = presenter
		return view
	
	}
}
