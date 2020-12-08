//
//  MainModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import UIKit

enum MainModuleAssemble {
	static func createMainModule(queryModel: IModelQueryService, coordinateController: ICoordinateController) -> UIViewController {
		let view = MainViewController()
		let presenter = MainPresenter(view: view, queryModel: queryModel, coordinateController: coordinateController)
		view.presenter = presenter
		return view
	}
}
