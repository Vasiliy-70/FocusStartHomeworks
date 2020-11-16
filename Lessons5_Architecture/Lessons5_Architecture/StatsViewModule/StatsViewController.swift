//
//  StatsViewController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//

import UIKit

protocol IStatsViewController: class {
	func set(data: String)
}

final class StatsViewController: UIViewController {
	
	private let customView = StatsView()
	var presenter: IStatsPresenter?
	
	override func loadView() {
		self.view = self.customView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension StatsViewController: IStatsViewController {
	func set(data: String) {
		self.customView.show(data: data)
	}
}
