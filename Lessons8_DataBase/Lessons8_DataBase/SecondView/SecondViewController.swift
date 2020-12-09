//
//  SecondViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

protocol ISecondViewController: class {

}

class SecondViewController: UIViewController {
	var presenter: ISecondPresenter?
	
	private var employeesTable = UITableView()
	private var cellId = "cellId"
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addEmployee))]
		self.navigationItem.title = "Employees"
		self.configureElements()
	}
	
	override func loadView() {
		self.view = SecondView(tableView: self.employeesTable)
	}
}

// MARK: ConfigureElements

extension SecondViewController {
	func configureElements() {
		
	}
	
	func configureEmployeesTable() {
		self.employeesTable.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
		
		self.employeesTable.delegate = self
		self.employeesTable.dataSource = self
	}
}

// MARK: UITableViewDelegate

extension SecondViewController: UITableViewDelegate {
	
}

// MARK:UITableViewDataSource

extension SecondViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath)
		return cell
	}
}

// MARK:

extension SecondViewController: ISecondViewController {
	
}


// MARK: Action

extension SecondViewController {
	@objc func addEmployee() {
		self.presenter?.showAddEmployeeView()
	}
}

