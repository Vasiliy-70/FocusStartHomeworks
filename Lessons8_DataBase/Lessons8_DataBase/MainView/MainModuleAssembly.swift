//
//  MainModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import UIKit

enum MainModuleAssembly {
	static func createMainModule(coordinateController: ICoordinateController) -> UIViewController {
		let view = MainViewController()
		let presenter = MainPresenter(view: view, coordinateController: coordinateController)
		view.presenter = presenter
		return view
	}
}
