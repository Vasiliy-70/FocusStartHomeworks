//
//  StatsViewController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//

import UIKit

protocol IStatsView: class {
	func show(string: String)
}

final class StatsViewController: UIViewController {
	
	private let customView = StatsView()
	var presenter: IStatsPresenter?
	
	override func loadView() {
		self.view = self.customView
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.getStatistic()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		self.presenter?.cleanStatistic()
	}
}

extension StatsViewController: IStatsView {
	func show(string: String) {
		self.customView.show(string: string)
	}
}
