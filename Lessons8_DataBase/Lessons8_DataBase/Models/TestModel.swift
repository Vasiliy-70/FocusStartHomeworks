//
//  TestModel.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import Foundation

class TestModel {
	private var companies: [String] = []
	private var employees: [String] = []
	
	func getCompaniesData() -> [String] {
		return self.companies
	}
	
	func setCompaniesData(_ data: [String]) {
		self.companies = data
	}
	
	func getEmployees() -> [String] {
		return self.employees
	}
	
	func setEmployeesData(_ data: [String]) {
		self.employees = data
	}
}
