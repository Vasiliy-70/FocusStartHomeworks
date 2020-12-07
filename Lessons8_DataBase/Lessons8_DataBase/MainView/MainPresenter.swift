//
//  MainPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import Foundation

protocol IMainPresenter: class {
	var companiesList: [String] { get }
	func requestData()
	func add(company: String)
	func remove(company: String, atIndex: Int)
}

final class MainPresenter {
	private weak var view: IMainView?
	private var coordinateController: ICoordinateController
	private var model: TestModel
	
	private var companies: [String] = [] {
		didSet {
			self.view?.updateData()
		}
	}
	
	public init(view: IMainView, model: TestModel, coordinateController: ICoordinateController) {
		self.view = view
		self.model = model
		self.coordinateController = coordinateController
	}
}

extension MainPresenter {
	func requestData() {
		self.companies = self.model.getData()
		self.view?.updateData()
	}
	
	func setData() {
		self.model.setData(self.companies)
	}
}

extension MainPresenter: IMainPresenter {
	func remove(company: String, atIndex: Int) {
		if self.companies[atIndex] == company {
			self.companies.remove(at: atIndex)
		}
	}
	
	func add(company: String) {
		self.companies.append(company)
	}
		
	var companiesList: [String] {
		get {
			return self.companies
		}
	}
}
