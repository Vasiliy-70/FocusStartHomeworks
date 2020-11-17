//
//  StatsViewController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//

import UIKit

protocol IStatsViewController: class {
	func set(allValues: [Int])
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
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.getStatistic()
	}
}

extension StatsViewController: IStatsViewController {
	func set(allValues: [Int]) {
		let desciption = "\nТвои попытки: \n\(allValues)"
		self.customView.show(data: desciption)
	}
}
