//
//  MainPresenter.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import Foundation

protocol IMainPresenter: class {
	func getDataFromModel()
	func writeDataToModel()
}

final class MainPresenter {
	
	weak var viewController: IMainViewController?
	private let model: Model
	
	init(viewController: IMainViewController, model: Model) {
		self.viewController = viewController
		self.model = model
	}
}

extension MainPresenter: IMainPresenter {

	func writeDataToModel() {
	}
	
	func getDataFromModel() {
		let minValue = self.model.minValue
		self.viewController?.set(data: String(minValue))
	}
	
}
	
