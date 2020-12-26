//
//  MainViewController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

protocol IMainViewUserAction: class {
	func check(value: String)
}

protocol IMainView: class {
	func show(tutorial: String)
	func show(value: String)
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

extension MainViewController: IMainView {
	func show(tutorial: String) {
		self.customView.show(tutorial: tutorial)
	}
	
	func show(value: String) {
		self.customView.show(value: value)
	}
}

extension MainViewController: IMainViewUserAction {
	func check(value: String) {
		guard let intValue = Int(value) else { return }
		self.presenter?.userValue = intValue
	}
}


