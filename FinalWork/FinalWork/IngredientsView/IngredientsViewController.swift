//
//  IngredientsViewController.swift
//  FinalWork
//
//  Created by Боровик Василий on 16.12.2020.
//

import UIKit

protocol IIngredientsViewController: class {
	func updateData()
}

protocol IIngredientsViewTableController: class {
	var cellId: String { get }
	var delegate: UITableViewDelegate { get }
	var dataSource: UITableViewDataSource { get }
}

final class IngredientsViewController: UIViewController {
	var presenter: IIngredientsViewPresenter?
	private var ingredientsList: [String]?
	private var cellIdentifier = "mainViewCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "Ингредиенты"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.viewDidLoad()
	}
	
	override func loadView() {
		self.view = IngredientsView(tableController: self)
	}
}

// MARK: UITableViewDelegate

extension IngredientsViewController: UITableViewDelegate {
	
}

// MARK: UITableViewDataSource

extension IngredientsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.ingredientsList.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
		cell.textLabel?.text = self.presenter?.ingredientsList[indexPath.row]
		return cell
	}
}

// MARK: IIngredientsViewController

extension IngredientsViewController: IIngredientsViewController {
	func updateData() {
		self.ingredientsList = self.presenter?.ingredientsList
		let view = self.view as? IIngredientsView
		view?.reloadTable()
	}
}

// MARK: IIngredientsViewTableController

extension IngredientsViewController: IIngredientsViewTableController {
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

