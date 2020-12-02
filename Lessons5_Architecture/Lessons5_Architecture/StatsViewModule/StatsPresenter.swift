//
//  StatsPresenter.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//

import Foundation

protocol IStatsPresenter: class {
	func getStatistic()
	func cleanStatistic()
}

final class StatsPresenter {
	weak var viewController: IStatsView?
	private let model: Model
	
	init(viewController: IStatsView, model: Model) {
		self.viewController = viewController
		self.model = model
	}
}

extension StatsPresenter: IStatsPresenter {
	func cleanStatistic() {
		self.model.clearHistory()
	}
	
	func getStatistic() {
		let previousValues = self.model.previousValues
		let description = "Поздравляю! Ты выиграл!\nТвои попытки: \n\(previousValues.description)"
		self.viewController?.show(string: description)
	}
}
