//
//  AddEmployeePresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

protocol IAddEmployeePresenter {
	func saveEmployee(name: String)
}

final class AddEmployeePresenter {
	weak var view: AddEmployeeViewController?
	private let queryModel = ModelQueryService.manager
	private let companyID: UUID
	
	public init(view: AddEmployeeViewController, companyID: UUID) {
		self.view = view
		self.companyID = companyID
	}
}

extension AddEmployeePresenter: IAddEmployeePresenter {
	func saveEmployee(name: String) {
		if (name != "") {
			let uuid = UUID().uuidString
			self.queryModel.add(employee: name, id: uuid, companyID: self.companyID)
		}
	}
}
