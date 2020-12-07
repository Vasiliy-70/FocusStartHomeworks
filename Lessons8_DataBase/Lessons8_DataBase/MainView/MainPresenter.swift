//
//  MainPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import Foundation

protocol IMainPresenter: class {
	var companiesList: [String] { get }
	func add(company: String)
	func remove(company: String, atIndex: Int)
	func requestData()
	func setData()
	func requestDetailView()
}

final class MainPresenter {
	private weak var view: IMainViewController?
	private var coordinateController: ICoordinateController
	private var model: TestModel
	
	private var companies: [String] = [] {
		didSet {
			self.view?.updateData()
		}
	}
	
	public init(view: IMainViewController, model: TestModel, coordinateController: ICoordinateController) {
		self.view = view
		self.model = model
		self.coordinateController = coordinateController
	}
}

extension MainPresenter: IMainPresenter {
	func requestDetailView() {
		self.coordinateController.showEmployeesList()
	}
	
	func requestData() {
		self.companies = self.model.getCompaniesData()
	}
	
	func setData() {
		self.model.setCompaniesData(self.companies)
	}
	
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
