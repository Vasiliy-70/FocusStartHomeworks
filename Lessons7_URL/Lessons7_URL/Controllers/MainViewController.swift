//
//  MainViewController.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 29.11.2020.
//

import UIKit

class MainViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "Table"
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	override func loadView() {
		self.view = MainView()
	}

}

