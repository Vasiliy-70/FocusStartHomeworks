//
//  StatsPresenter.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//


protocol IStatsPresenter: class {
	func getDataFromModel()
}

final class StatsPresenter {
	
	weak var viewController: IStatsViewController?
	private let model: Model
	
	init(viewController: IStatsViewController, model: Model) {
		self.viewController = viewController
		self.model = model
	}
}

extension StatsPresenter: IStatsPresenter {
	func getDataFromModel() {
		let minValue = self.model.minValue
		self.viewController?.set(data: String(minValue))
	}
}
