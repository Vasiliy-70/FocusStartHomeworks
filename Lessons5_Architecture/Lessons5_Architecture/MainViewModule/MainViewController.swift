//
//  MainViewController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

protocol IMainViewUserAction: class {
	func receiveUser(value: String)
}

protocol IMainViewController: class {
	func set(minValue: Int, maxValue: Int)
}

final class MainViewController: UIViewController {
	
	private let customView = MainView()
	var presenter: IMainPresenter?
	
	override func loadView() {
		self.view = self.customView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.customView.delegate = self
		self.presenter?.requestData()
	}
}

extension MainViewController: IMainViewController {
	func set(minValue: Int, maxValue: Int) {
		let description = "Угадай число, которое я загадал😛\n (подсказка: диапазон от \(minValue) до \(maxValue))"
		self.customView.show(data: description)
	}
}

extension MainViewController: IMainViewUserAction {
	func receiveUser(value: String) {
		guard let intValue = Int(value) else { return }
		self.presenter?.userValue = intValue
	}
}


