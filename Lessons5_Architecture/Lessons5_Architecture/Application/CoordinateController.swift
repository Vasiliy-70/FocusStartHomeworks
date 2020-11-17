//
//  CoordinateController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//

import UIKit
	
enum ModuleNumber {
	case first
	case second
}

final class CoordinateController {
	private var views = [ModuleNumber : UIViewController]()
	
	func addModule(number: ModuleNumber, vc: UIViewController) {
		views[number] = vc
	}
}

extension CoordinateController {
	func switchModule() {
		
		guard let current = views[.first] else { return assertionFailure() }
		guard let next = views[.second] else { return assertionFailure() }
		
		current.navigationController?.pushViewController(next, animated: false)
		
	}
}
