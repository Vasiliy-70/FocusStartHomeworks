//
//  SecondPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

protocol ISecondPresenter: class {
	var employeeList: [String] { get }
	func removeEmployeeAt(index: Int)
	func requestData()
	func showEmployeeInfoAt(index: Int, editMode: Bool)
}

final class SecondPresenter {
	weak var view: ISecondViewController?
	private let coordinateController: ICoordinateController
	private let queryModel = ModelQueryService.manager
	
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
	
	public init(view: ISecondViewController, coordinateController: ICoordinateController, companyID: UUID) {
		self.view = view
		self.coordinateController = coordinateController
		self.companyID = companyID
		self.queryModel.register(observer: self, modelType: .employee)
	}
}

extension SecondPresenter: ISecondPresenter {
	func showEmployeeInfoAt(index: Int, editMode: Bool) {
		if let uuid = self.employeeData[index].id {
			self.coordinateController.showEmployeeInfo(employeeID: uuid, companyID: self.companyID, editMode: editMode)
		}
	}
	
	func removeEmployeeAt(index: Int) {
		if let id = self.employeeData[index].id {
			self.queryModel.removeEmployeeAt(Id: id)
		}
	}
	
	var employeeList: [String] {
		get {
			self.employeeNames
		}
	}
	
	func requestData() {
		self.employeeData = self.queryModel.fetchRequestEmployees(companyID: self.companyID) ?? []
	}
}

extension SecondPresenter: IQueueModelObserver {
	func notifierDataUpdate() {
		self.requestData()
	}
}
