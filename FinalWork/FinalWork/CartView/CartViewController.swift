//
//  CartViewController.swift
//  FinalWork
//
//  Created by Боровик Василий on 16.12.2020.
//

import UIKit

protocol ICartViewController: class {
	func updateData()
}

protocol ICartViewTableController: class {
	var cellId: String { get }
	var delegate: UITableViewDelegate { get }
	var dataSource: UITableViewDataSource { get }
}

final class CartViewController: UIViewController {
	var presenter: ICartViewPresenter?
	private var ingredientsList: [String]?
	private var cellIdentifier = "mainViewCell"
	
	public init() {
		super.init(nibName: nil, bundle: nil)
		
		self.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "shopping-cart"), selectedImage: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.viewDidLoad()
		self.tabBarController?.title = "Корзина"
	}
	
	override func loadView() {
		self.view = CartView(tableController: self)
	}
}

// MARK: UITableViewDelegate

extension CartViewController: UITableViewDelegate {
	
}

// MARK: UITableViewDataSource

extension CartViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.ingredientsList.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
		cell.textLabel?.text = self.presenter?.ingredientsList[indexPath.row]
		return cell
	}
}

// MARK: ICartViewController

extension CartViewController: ICartViewController {
	func updateData() {
		self.ingredientsList = self.presenter?.ingredientsList
		let view = self.view as? ICartView
		view?.reloadTable()
	}
}

// MARK: ICartViewTableController

extension CartViewController: ICartViewTableController {
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

