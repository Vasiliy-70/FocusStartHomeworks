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
	
	public init(view: AddEmployeeViewController) {
		self.view = view
		
	}
}

extension AddEmployeePresenter: IAddEmployeePresenter {
	func saveEmployee(name: String) {
	}
}
