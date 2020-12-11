//
//  MainPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import Foundation

protocol IMainPresenter: class {
	var companyList: [String] { get }
	func actionAlertSave()
	func actionDeleteRow()
	func actionTapRow()
	func viewDidLoad()
}

final class MainPresenter {
	private weak var view: IMainViewController?
	private var coordinateController: ICoordinateController
	private var queryModel: ModelQueryService
	
	private var companyNames = [String]() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var companyData = [Company]() {
		didSet {
			self.companyNames.removeAll()
			for company in self.companyData {
				if let name = company.name {
					self.companyNames.append(name)
				}
			}
		}
	}
	
	public init(view: IMainViewController, coordinateController: ICoordinateController, queryModel: ModelQueryService) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
	}
}

extension MainPresenter {
	func requestData() {
		self.companyData = self.queryModel.fetchRequestCompany() ?? []
	}
}

// MARK: IMainPresenter

extension MainPresenter: IMainPresenter {
	func viewDidLoad() {
		self.requestData()
	}
	
	func actionTapRow() {
		if let index = self.view?.selectedRow,
		   let id = self.companyData[index].id {
			self.coordinateController.showEmployeesCompanyAt(companyID: id)
		}
	}
	
	var companyList: [String] {
		self.companyNames
	}
	
	func actionDeleteRow() {
		if let index = self.view?.selectedRow,
		   let id = self.companyData[index].id {
			self.queryModel.removeCompanyAt(id: id)
			self.requestData()
		}
	}
	
	func actionAlertSave() {
		if let company = self.view?.companyName {
			self.queryModel.add(company: company)
			self.requestData()
		}
	}
}
