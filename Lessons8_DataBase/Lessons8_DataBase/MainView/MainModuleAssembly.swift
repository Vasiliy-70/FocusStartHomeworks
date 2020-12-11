//
//  MainModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import UIKit

enum MainModuleAssembly {
	static func createMainModule(coordinateController: ICoordinateController, queryModel: ModelQueryService) -> UIViewController {
		let view = MainViewController()
		let presenter = MainPresenter(view: view, coordinateController: coordinateController, queryModel: queryModel)
		view.presenter = presenter
		return view
	}
}
