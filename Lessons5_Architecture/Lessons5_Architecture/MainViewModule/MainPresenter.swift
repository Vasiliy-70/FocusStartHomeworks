//
//  MainPresenter.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

protocol IMainPresenter: class {
	func requestData()
	var userValue: Int { get set }
}

final class MainPresenter {
	weak var viewController: IMainView?
	var coordinateController: ICoordinateController?
	private var model: Model
	
	private var receivedValue = 0
	private var minValue: Int
	private var maxValue: Int
	
	init(coordinateController: ICoordinateController, viewController: IMainView, model: Model) {
		self.coordinateController = coordinateController
		self.viewController = viewController
		self.model = model
		self.minValue = self.model.minValue
		self.maxValue = self.model.maxValue
	}
}

private extension MainPresenter {
	func compareValues(receivedValue: Int) {
		let randomValue = Int.random(in: self.minValue...self.maxValue)
		if randomValue == self.receivedValue {
			self.coordinateController?.showStatisticsAt(model: self.model)
		}
	}
	
	func safeUserData() {
		self.model.previousValues.append(self.receivedValue)
	}
}

extension MainPresenter: IMainPresenter {
	var userValue: Int {
		get {
			return self.receivedValue
		}
		set {
			self.viewController?.show(value: "")
			self.receivedValue = newValue
			self.safeUserData()
			self.compareValues(receivedValue: newValue)
		}
	}
	
	func requestData() {
		let description = "Угадай число, которое я загадал😛\n (подсказка: диапазон от \(self.minValue) до \(self.maxValue))"
		self.viewController?.show(tutorial: description)
	}
}
