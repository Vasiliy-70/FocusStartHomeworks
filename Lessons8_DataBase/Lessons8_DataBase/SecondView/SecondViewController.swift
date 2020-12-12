//
//  SecondViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

protocol ISecondViewController: class {
	func updateData()
	var employeeName: String? { get }
	var selectedRow: Int? { get }
}

protocol ISecondViewTableController: class {
	var cellId: String { get }
	var delegate: UITableViewDelegate { get }
	var dataSource: UITableViewDataSource { get }
}

final class SecondViewController: UIViewController {
	var presenter: ISecondPresenter?

	private var cellIdentifier = "cellId"
	private var employee: String?
	private var indexRow: Int?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.configureNavigationItems()
	}
	
	override func loadView() {
		self.view = SecondView(tableController: self)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.viewWillAppear()
	}
}

// MARK: ConfigureElements

extension SecondViewController {
	func configureNavigationItems() {
		let addEmployeeButton = UIBarButtonItem(barButtonSystemItem: .add,
												target: self, action: #selector(self.actionBarButton))
		self.navigationItem.rightBarButtonItems = [addEmployeeButton]
		self.navigationItem.title = "Employees"
	}
}

// MARK: UITableViewDelegate

extension SecondViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let view = self.view as? ISecondViewTable
			if view?.textInCellForRow(at: indexPath) != nil {
				self.indexRow = indexPath.row
				self.presenter?.actionDeleteRow()
			}
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.indexRow = indexPath.row
		self.presenter?.actionTapRow()
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let editingAction = UIContextualAction(style: .normal, title: "Edit") {
			(action, view, handler)  in
			self.indexRow = indexPath.row
			self.presenter?.actionEditRow()
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
	var employeeName: String? {
		self.employee
	}
	
	var selectedRow: Int? {
		self.indexRow
	}
	
	func updateData() {
		let view = self.view as? ISecondViewTable
		view?.reloadTable()
	}
}

// MARK: ISecondViewTableController

extension SecondViewController: ISecondViewTableController {
	var cellId: String {
		self.cellIdentifier
	}
	
	var delegate: UITableViewDelegate {
		self
	}
	
	var dataSource: UITableViewDataSource {
		self
	}
}

// MARK: Action

extension SecondViewController {
	@objc func actionBarButton() {
		self.presenter?.actionBarButton()
	}
}

