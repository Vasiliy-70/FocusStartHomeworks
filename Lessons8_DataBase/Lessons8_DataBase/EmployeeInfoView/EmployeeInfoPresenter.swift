//
//  EmployeeInfoPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

protocol IEmployeeInfoPresenter {
	var employee: [EmployeePropertyKey:String?] { get }
	func actionSaveButton()
	func viewDidLoad()
}

final class EmployeeInfoPresenter {
	weak var view: EmployeeInfoViewController?
	private let queryModel: ModelQueryService
	private let companyID: UUID
	private let employeeID: UUID
	
	private var employeeInfo = [EmployeePropertyKey:String?]() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var employeeData = [Employee]() {
		willSet {
			self.employeeInfo.removeAll()
			self.employeeInfo[.name] = newValue.first?.name
			self.employeeInfo[.age] = newValue.first?.age.description
			self.employeeInfo[.education] = newValue.first?.education
			self.employeeInfo[.experience] = newValue.first?.experience.description
			self.employeeInfo[.position] = newValue.first?.position
		}
	}
	
	public init(view: EmployeeInfoViewController, queryModel: ModelQueryService, companyID: UUID, employeeID: UUID?) {
		self.view = view
		self.companyID = companyID
		self.employeeID = employeeID ?? UUID()
		self.queryModel = queryModel
		
		self.requestData()
	}
}

extension EmployeeInfoPresenter {
	func requestData() {
		self.employeeData = self.queryModel.fetchRequestEmployeeInfo(employeeID: self.employeeID) ?? []
	}
}


// MARK: IEmployeeInfoPresenter

extension EmployeeInfoPresenter: IEmployeeInfoPresenter {
	var employee: [EmployeePropertyKey : String?] {
		self.employeeInfo
	}
	
	func viewDidLoad() {
		self.requestData()
	}
	
	func actionSaveButton() {
		guard let info = self.view?.employeeInfo
		else {
			self.view?.showAlert(message: "Invalid data entered")
			return
		}
		
		guard let name = info[.name] as? String,
			  name != ""
		else {
			self.view?.showAlert(message: "Invalid data entered in field: Имя")
			return
		}
		
		guard let age = Int16(info[.age] as? String ?? "none"),
			  age > 0
		else {
			self.view?.showAlert(message: "Invalid data entered in field: Возраст")
			return
		}
		
		guard Int16(info[.experience] as? String ?? "none") != nil
		else {
			self.view?.showAlert(message: "Invalid data entered in field: Стаж работы")
			return
		}
		
		guard  let position = info[.position] as? String,
			   position != ""
		else {
			self.view?.showAlert(message: "Invalid data entered in field: Должность")
			return
		}
	
		if self.view?.editMode == .editing {
			self.queryModel.change(employee: info, employeeID: self.employeeID)
		} else {
			self.queryModel.add(employee: info, companyID: self.companyID)
		}
		self.view?.navigationController?.popViewController(animated: true)
	}
}

