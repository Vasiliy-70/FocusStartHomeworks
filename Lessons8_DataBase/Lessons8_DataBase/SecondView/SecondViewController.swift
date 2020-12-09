//
//  SecondViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

protocol ISecondViewController: class {
	func updateData()
}

class SecondViewController: UIViewController {
	var presenter: ISecondPresenter?
	
	private var employeesTable = UITableView()
	private var cellIdentifier = "cellId"
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addEmployee))]
		self.navigationItem.title = "Employees"
		self.configureEmployeesTable()
	}
	
	override func loadView() {
		self.view = SecondView(tableView: self.employeesTable)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.requestData()
	}
}

// MARK: ConfigureElements

extension SecondViewController {
	func configureEmployeesTable() {
		self.employeesTable.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
		
		self.employeesTable.delegate = self
		self.employeesTable.dataSource = self
	}
}

// MARK: UITableViewDelegate

extension SecondViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			if (self.employeesTable.cellForRow(at: indexPath)?.textLabel?.text) != nil {
				self.presenter?.removeEmployeeAt(index: indexPath.row)
			}
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.presenter?.showEmployeeInfo(editMode: false)
	}
}

// MARK:UITableViewDataSource

extension SecondViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.employeeList.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
		cell.textLabel?.text = self.presenter?.employeeList[indexPath.row]
		return cell
	}
}

// MARK:

extension SecondViewController: ISecondViewController {
	func updateData() {
		self.employeesTable.reloadData()
	}
}


// MARK: Action

extension SecondViewController {
	@objc func addEmployee() {
		self.presenter?.showEmployeeInfo(editMode: true)
	}
}

