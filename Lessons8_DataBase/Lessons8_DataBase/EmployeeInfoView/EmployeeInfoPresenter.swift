//
//  EmployeeInfoPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

protocol IEmployeeInfoPresenter {
	func saveEmployee(info: [EmployeePropertyKey:String?], editMode: EmployeeInfoMode)
	func getEmployeeInfo() -> [EmployeePropertyKey:String?]
}

enum EmployeePropertyKey {
	case name
	case age
	case experience
	case education
	case position
}

final class EmployeeInfoPresenter {
	weak var view: EmployeeInfoViewController?
	private let queryModel: ModelQueryService
	private let companyID: UUID
	private let employeeID: UUID
	
	private var employeeInfo = [EmployeePropertyKey:String?]()
	
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

// MARK: IEmployeeInfoPresenter

extension EmployeeInfoPresenter: IEmployeeInfoPresenter {
	func getEmployeeInfo() -> [EmployeePropertyKey : String?] {
		return self.employeeInfo
	}
	
	func saveEmployee(info: [EmployeePropertyKey:String?], editMode: EmployeeInfoMode) {
		
		if let name = info[.name] as? String,
		   name != "",
		   let age = Int16(info[.age] as? String ?? "none"),
		   age > 0,
		   let _ = Int16(info[.experience] as? String ?? "none"),
		   let _ = info[.education] as? String,
		   let position = info[.position] as? String,
		   position != ""  {
			if editMode == .editing {
				self.queryModel.change(employee: info, employeeID: self.employeeID)
			} else {
				self.queryModel.add(employee: info, companyID: self.companyID)
			}
			self.view?.navigationController?.popViewController(animated: true)
		} else {
			self.view?.showAlert()
		}
	}
}

extension EmployeeInfoPresenter {
	func requestData() {
		self.employeeData = self.queryModel.fetchRequestEmployeeInfo(employeeID: self.employeeID) ?? []
	}
}
