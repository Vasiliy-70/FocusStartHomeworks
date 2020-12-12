//
//  SecondPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

protocol ISecondPresenter: class {
	var employeeList: [String] { get }
	func actionDeleteRow()
	func actionEditRow()
	func actionTapRow()
	func actionBarButton()
	func viewWillAppear()
}

final class SecondPresenter {
	weak var view: ISecondViewController?
	private let coordinateController: ICoordinateController
	private let queryModel: ModelQueryService
	
	private var companyID: UUID
	private var ID: UUID?
	private var employeeNames = [String]() {
		didSet {
			self.view?.updateData()
		}
	}
	private var employeeData = [Employee]() {
		didSet {
			self.employeeNames.removeAll()
			for employee in self.employeeData {
				if let name = employee.name {
					self.employeeNames.append(name)
				}
			}
		}
	}
	
	public init(view: ISecondViewController, coordinateController: ICoordinateController, queryModel: ModelQueryService, companyID: UUID) {
		self.view = view
		self.coordinateController = coordinateController
		self.companyID = companyID
		self.queryModel = queryModel
	}
}

extension SecondPresenter {
	func requestData() {
		self.employeeData = self.queryModel.fetchRequestEmployees(companyID: self.companyID) ?? []
	}
}


// MARK: ISecondPresenter

extension SecondPresenter: ISecondPresenter {
	func viewWillAppear() {
		self.requestData()
	}
	
	func actionBarButton() {
		self.coordinateController.showEmployeeInfo(employeeID: nil, companyID: self.companyID, editMode: .addition)
	}
	
	func actionTapRow() {
		if	let index = self.view?.selectedRow,
			let id = self.employeeData[index].id {
			self.coordinateController.showEmployeeInfo(employeeID: id, companyID: self.companyID, editMode: .showing)
		}
	}
	
	func actionDeleteRow() {
		if	let index = self.view?.selectedRow,
			let id = self.employeeData[index].id {
			self.queryModel.removeEmployeeAt(id: id)
			self.requestData()
		}
	}
	
	func actionEditRow() {
		if	let index = self.view?.selectedRow,
			let id = self.employeeData[index].id {
			self.coordinateController.showEmployeeInfo(employeeID: id, companyID: self.companyID, editMode: .editing)
		}
	}
	
	var employeeList: [String] {
		self.employeeNames
	}
}
