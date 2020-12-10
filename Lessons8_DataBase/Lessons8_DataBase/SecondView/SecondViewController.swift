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
		
		self.configureNavigationItems()
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
	func configureNavigationItems() {
		let addEmployeeButton = UIBarButtonItem(barButtonSystemItem: .add,
												target: self, action: #selector(self.addEmployee))
		self.navigationItem.rightBarButtonItems = [addEmployeeButton]
		self.navigationItem.title = "Employees"
	}
	
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
		self.presenter?.showEmployeeInfoAt(index: indexPath.row, editMode: .showing)
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let editingAction = UIContextualAction(style: .normal, title: "Edit") {
			(action, view, handler)  in
			self.presenter?.showEmployeeInfoAt(index: indexPath.row, editMode: .editing)
		}
		editingAction.backgroundColor = .systemBlue
		let configuration = UISwipeActionsConfiguration(actions: [editingAction])
		configuration.performsFirstActionWithFullSwipe = false
		return configuration
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

// MARK: ISecondViewController

extension SecondViewController: ISecondViewController {
	func updateData() {
		self.employeesTable.reloadData()
	}
}


// MARK: Action

extension SecondViewController {
	@objc func addEmployee() {
		self.presenter?.addNewEmployee()
	}
}

