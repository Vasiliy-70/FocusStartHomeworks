//
//  MainPresenter.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

protocol IMainPresenter: class {
	func requestData()
	var userValue: Int { get set }
}

final class MainPresenter {
	
	weak var viewController: IMainViewController?
	weak var coordinateController: CoordinateController?
	private var model: Model
	
	private var receivedValue = 0
	private var minValue: Int
	private var maxValue: Int
	
	init(coordinateController: CoordinateController, viewController: IMainViewController, model: Model) {
		self.coordinateController = coordinateController
		self.viewController = viewController
		self.model = model
		self.minValue = self.model.minValue
		self.maxValue = self.model.maxValue
	}
}

extension MainPresenter {
	func compareValues(receivedValue: Int) {
		let randomValue = Int.random(in: self.minValue...self.maxValue)
		if randomValue == self.receivedValue {
			self.coordinateController?.switchModule()
		}
	}
	
	func safeUserData() {
		self.model.previousValue.append(self.receivedValue)
	}
}

extension MainPresenter: IMainPresenter {
	var userValue: Int {
		get {
			return self.receivedValue
		}
		set {
			self.receivedValue = newValue
			self.safeUserData()
			self.compareValues(receivedValue: newValue)
			
		}
	}
	
	func requestData() {
		self.minValue = self.model.minValue
		self.maxValue = self.model.maxValue
		self.viewController?.set(minValue: self.minValue, maxValue: self.maxValue)
	}
}
