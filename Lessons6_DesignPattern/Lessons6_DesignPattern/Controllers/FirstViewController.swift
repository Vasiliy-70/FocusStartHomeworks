//
//  FirstViewController.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 19.11.2020.
//

import UIKit

final class FirstViewController: UIViewController {

	// MARK: LifeCycle
	
	private let customView: BaseView
	
	init(view: BaseView) {
		self.customView = view
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.view = customView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}
}

