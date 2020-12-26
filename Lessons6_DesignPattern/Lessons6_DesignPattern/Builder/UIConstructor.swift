//
//  UIConstructor.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 21.11.2020.
//

import UIKit

class UIConstructor {
	private var builder: Builder?
	
	func update(builder: Builder) {
		self.builder = builder
	}
	
	func buildUI(elements: [UIElements], backgroundColor: UIColor) {
		self.builder?.createViewController(elements: elements, backgroundColor: backgroundColor)
	}
}
