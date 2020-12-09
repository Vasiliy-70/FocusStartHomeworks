//
//  MainPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import Foundation

protocol IMainPresenter: class {
	var companyList: [String] { get }
	func add(company: String)
	func removeCompanyAt(index: Int)
	func requestData()
	func setData()
	func requestEmployeeCompanyAt(index: Int)
}

protocol IQueueModelObserver: class {
	func notifierDataUpdate()
}

final class MainPresenter {
	private weak var view: IMainViewController?
	private var coordinateController: ICoordinateController
	private var queryModel = ModelQueryService.manager
	
	private var companyNames = [String]() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var companyData = [Company]() {
		didSet {
			self.companyNames.removeAll()
			for company in self.companyData {
				print(company.id)
				/*if let name = company.name,
				!self.companyNames.contains(name) {
				self.companyNames.append(name)*/
				if let name = company.name {
					self.companyNames.append(name)
				}
			}
			/*for company in self.companyData {
			if let name = company.name,
			!self.companyNames.contains(name) {
			self.companyNames.append(name)
			}
			}*/
		}
	}
	
	public init(view: IMainViewController, coordinateController: ICoordinateController) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel.register(observer: self, modelType: .company)
	}
}

extension MainPresenter: IMainPresenter {
	var companyList: [String] {
		get {
			self.companyNames
		}
	}
	
	func requestEmployeeCompanyAt(index: Int) {
		if let uuid = self.companyData[index].id {
			self.coordinateController.showEmployeesCompanyAt(companyID: uuid)
		}
	}
	
	func requestData() {
		self.companyData = self.queryModel.fetchRequestCompany() ?? []
		//self.companies = self.model.getCompaniesData()
	}
	
	func setData() {
		
		//self.model.setCompaniesData(self.companies)
	}
	
	func removeCompanyAt(index: Int) {
		//self.companyNames.remove(at: index)
		if let uuid = self.companyData[index].id {
			self.queryModel.removeCompanyAt(Id: uuid)
		}
	}
	
	func add(company: String) {
		let uuid = UUID().uuidString
		//self.companyNames.append(company)
		self.queryModel.add(company: company, id: uuid)
	}
}

extension MainPresenter: IQueueModelObserver {
	func notifierDataUpdate() {
		self.requestData()
	}
}
