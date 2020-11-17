//
//  Model.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import Foundation

final class Model {
	var minValue: Int
	var maxValue: Int
	var previousValue = [Int]()
	
	init(minValue: Int, maxValue: Int) {
		self.minValue = minValue
		self.maxValue = maxValue
	}
}
