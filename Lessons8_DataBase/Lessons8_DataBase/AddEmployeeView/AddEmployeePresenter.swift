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
	
	public init(view: AddEmployeeViewController, companyID: UUID) {
		self.view = view
		self.companyID = companyID
		self.requestData()
	}
}

extension AddEmployeePresenter: IAddEmployeePresenter {
	func getEmployeeInfo() -> [EmployeePropertyKey : String?] {
		return self.employeeInfo
	}
	
	func saveEmployee(info: [EmployeePropertyKey:String?]) {
		
		if let name = info[.name] as? String,
		   let age = Int16(info[.age] as? String ?? "none"),
		   age > 10,
		   let experience = Int16(info[.experience] as? String ?? "none"),
		   let education = info[.education] as? String,
		   let position = info[.position] as? String {

			self.queryModel.add(employee: info, companyID: self.companyID)
			self.view?.navigationController?.popViewController(animated: true)
		}
		
		/*
		   info[.age] != "",
		   info[.position] != "" {
			let age = (info[.age] ?? "") ?? "none"
			let experience = (info[.experience] ?? "") ?? "none"
			if Int16(age) != nil,
			   Int16(experience) != nil {
				let uuid = UUID().uuidString
				self.queryModel.add(employee: info[.name], id: uuid, companyID: self.companyID)
			}
		}*/
		/*if (name != "") {
			let uuid = UUID().uuidString
			self.queryModel.add(employee: name, id: uuid, companyID: self.companyID)
		}*/
	}
}

extension AddEmployeePresenter {
	func requestData() {
		self.employeeData = self.queryModel.fetchRequestEmployees(companyID: self.companyID) ?? []
	}
}
