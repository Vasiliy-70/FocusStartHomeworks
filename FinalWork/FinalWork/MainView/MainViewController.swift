//
//  MainViewController.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol IMainViewController: class {
	func updateData()
	var selectedRow: Int? { get }
}

protocol IMainViewTableController: class {
	var cellId: String { get }
	var delegate: UITableViewDelegate { get }
	var dataSource: UITableViewDataSource { get }
}

final class MainViewController: UIViewController {
	var presenter: IMainPresenter?
	private var recipeList: [String]?
	private var currentRow: Int?
	private var cellIdentifier = "mainViewCell"
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.configureTabBarController()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.viewDidLoad()
		self.tabBarController?.title = "Рецепты"
	}
	
	override func loadView() {
		self.view = MainView(tableController: self)
	}
}

extension MainViewController {
	func configureTabBarController() {
		self.tabBarItem = UITabBarItem(title: "Каталог", image: UIImage(named: "book-simple-7"), selectedImage: nil)
		
		self.navigationItem.rightBarButtonItems = [
			UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.actionAddButton))
		]
	}
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
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

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.recipeList.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
		cell.textLabel?.text = self.presenter?.recipeList[indexPath.row]
		return cell
	}
}

// MARK: IMainViewController

extension MainViewController: IMainViewController {
	func updateData() {
		self.recipeList = self.presenter?.recipeList
		let view = self.view as? IMainView
		view?.reloadTable()
	}
	
	var selectedRow: Int? {
		self.currentRow
	}
}

// MARK: IMainViewTableController

extension MainViewController: IMainViewTableController {
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

extension MainViewController {
	@objc func actionAddButton() {
		self.presenter?.actionAddButton()
	}
}
