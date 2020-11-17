//
//  MainViewController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

protocol IMainViewDelegate: class {
	func buttonPushed()
}

protocol IMainViewController: class {
	func set(data: String)
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
	}
}

extension MainViewController: IMainViewController {
	func set(data: String) {
		self.customView.show(data: data)
	}
}

extension MainViewController: IMainViewDelegate {
	
	func buttonPushed() {
		self.presenter?.userDataInput()
	}
}


