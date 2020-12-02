//
//  Model.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

final class Model {
	let minValue: Int
	let maxValue: Int
	var previousValues = [Int]()
	
	init(minValue: Int, maxValue: Int) {
		self.minValue = minValue
		self.maxValue = maxValue
	}
	
	func clearHistory() {
		self.previousValues = []
	}
}
