//
//  AddEmployeePresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

protocol IAddEmployeePresenter {
	func saveEmployee(info: [EmployeePropertyKey:String?])
	func getEmployeeInfo() -> [EmployeePropertyKey:String?]
}

enum EmployeePropertyKey {
	case name
	case age
	case experience
	case education
	case position
}

final class AddEmployeePresenter {
	weak var view: AddEmployeeViewController?
	private let queryModel = ModelQueryService.manager
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
	
	public init(view: AddEmployeeViewController, companyID: UUID, employeeID: UUID) {
		self.view = view
		self.companyID = companyID
		self.employeeID = employeeID
		self.requestData()
	}
}

extension AddEmployeePresenter: IAddEmployeePresenter {
	func getEmployeeInfo() -> [EmployeePropertyKey : String?] {
		return self.employeeInfo
	}
	
	func saveEmployee(info: [EmployeePropertyKey:String?]) {
		
		if let _ = info[.name] as? String,
		   let age = Int16(info[.age] as? String ?? "none"),
		   age > 10,
		   let _ = Int16(info[.experience] as? String ?? "none"),
		   let _ = info[.education] as? String,
		   let _ = info[.position] as? String {

			self.queryModel.add(employee: info, companyID: self.companyID)
			self.view?.navigationController?.popViewController(animated: true)
		}
	}
}

extension AddEmployeePresenter {
	func requestData() {
		self.employeeData = self.queryModel.fetchRequestEmployeeInfo(employeeID: self.employeeID) ?? []
	}
}
