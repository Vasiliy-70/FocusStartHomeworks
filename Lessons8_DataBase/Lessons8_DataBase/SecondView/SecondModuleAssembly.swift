//
//  SecondModuleAssembly.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

enum SecondModuleAssembly {
	static func createSecondModule(coordinateController: ICoordinateController) -> UIViewController {
		let view = SecondViewController()
		let presenter = SecondPresenter(view: view, coordinateController: coordinateController)
		view.presenter = presenter
		return view
	}
}
