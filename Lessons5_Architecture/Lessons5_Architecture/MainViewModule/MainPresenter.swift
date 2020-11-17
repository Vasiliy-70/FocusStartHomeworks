//
//  MainPresenter.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

protocol IMainPresenter: class {
	func userDataInput()
	//func getDataFromModel()
	//func writeDataToModel()
}

final class MainPresenter {
	
	weak var viewController: IMainViewController?
	weak var coordinateController: CoordinateController?
	private let model: Model
	
	init(coordinateController: CoordinateController, viewController: IMainViewController, model: Model) {
		self.coordinateController = coordinateController
		self.viewController = viewController
		self.model = model
	}
}

extension MainPresenter: IMainPresenter {

	/*func writeDataToModel() {
	}*/
	
	func userDataInput() {
		let minValue = self.model.minValue
		self.viewController?.set(data: String(minValue))
		self.coordinateController?.switchModule()
	}
	
}
