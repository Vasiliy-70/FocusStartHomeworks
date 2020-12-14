//
//  IngredientsEditViewController.swift
//  FinalWork
//
//  Created by Боровик Василий on 15.12.2020.
//

import UIKit

protocol IIngredientsEditViewController: class {
	func updateData()
	var selectedRow: Int? { get }
}

protocol IIngredientEditViewTableController: class {
	var cellId: String { get }
	var delegate: UITableViewDelegate { get }
	var dataSource: UITableViewDataSource { get }
}

final class IngredientsEditViewController: UIViewController {
	var presenter: IIngredientsEditViewPresenter?
	private var ingredientList: [String]?
	private var currentRow: Int?
	private var cellIdentifier = "ingredientViewCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.configureNavigationBar()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.viewDidLoad()
	}
	
	override func loadView() {
		self.view = IngredientsEditView(tableController: self)
	}
}

extension IngredientsEditViewController {
	func configureNavigationBar() {
		self.navigationItem.rightBarButtonItems = [
			UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.actionAddButton))
		]
		self.navigationItem.title = "Ингредиенты"
	}
}

// MARK: UITableViewDelegate

extension IngredientsEditViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let view = self.view as? IMainView
			if view?.textInCellForRow(at: indexPath) != nil {
				self.currentRow = indexPath.row
				self.presenter?.actionDeleteRow()
			}
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.currentRow = indexPath.row
		self.presenter?.actionTapRow()
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let editingAction = UIContextualAction(style: .normal, title: "Edit") {
			(action, view, handler) in
			self.currentRow = indexPath.row
			self.presenter?.actionEditRow()
		}
		editingAction.backgroundColor = .systemBlue
		let configuration = UISwipeActionsConfiguration(actions: [editingAction])
		configuration.performsFirstActionWithFullSwipe = false
		return configuration
	}
}

// MARK: UITableViewDataSource

extension IngredientsEditViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.ingredientList.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
		cell.textLabel?.text = self.presenter?.ingredientList[indexPath.row]
		return cell
	}
}

// MARK: IIngredientsEditViewController

extension IngredientsEditViewController: IIngredientsEditViewController {
	func updateData() {
		self.ingredientList = self.presenter?.ingredientList
		let view = self.view as? IMainView
		view?.reloadTable()
	}
	
	var selectedRow: Int? {
		self.currentRow
	}
}

// MARK: IIngredientEditViewTableController

extension IngredientsEditViewController: IIngredientEditViewTableController {
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

extension IngredientsEditViewController {
	@objc func actionAddButton() {
		self.presenter?.actionAddButton()
	}
}
