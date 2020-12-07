//
//  TestModel.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import Foundation

class TestModel {
	private var Data: [String] = []
	
	func getData() -> [String] {
		return self.Data
	}
	
	func setData(_ data: [String]) {
		self.Data = data
	}
}
