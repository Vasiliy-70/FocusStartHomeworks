//
//  ModuleAssembly.swift.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 01.12.2020.
//

import UIKit

enum ModuleAssembly {
	static func createMainModule() -> UIViewController {
		let view = MainViewController()
		let queryService = QueryService()
		let presenter = MainPresenter(view: view, queryService: queryService)
		view.presenter = presenter
		return view
	}
}
