//
//  MainViewController.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 29.11.2020.
//

import UIKit

protocol IMainViewUserAction: class {
	func getImageAt(url: String)
}

protocol IMainViewController: class {
	func responseError(error: String)
	func updateImage()
}

class MainViewController: UIViewController {
	
	private var tableView = UITableView()
	private var tableCell = TableCellView()
	private var cellIdentifier = "cellIdentifier"
	
	var presenter: IMainPresenter?
	
	private enum Constants {
		static let tableViewRowHeight: CGFloat = 50
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "Table"
		self.createTable()
	}
	
	override func loadView() {
		self.view = MainView(delegate: self, tableView: self.tableView)
	}
}

extension MainViewController {
	func createTable() {
		self.tableView.register(TableCellView.self, forCellReuseIdentifier: self.cellIdentifier)
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
	}
}

// MARK: TableViewDelegate

extension MainViewController:  UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

// MARK: TableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.image.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? TableCellView else { assertionFailure("No TableCellView"); return UITableViewCell() }
		cell.mainImage = self.presenter?.image[indexPath.row]
		cell.layoutSubviews()
		return cell
	}
	
}

// MARK: IMainViewUserAction

extension MainViewController: IMainViewUserAction {
	func getImageAt(url: String) {
		if var view = self.view as? IMainView {
			view.loadingImage = true
		}
		self.presenter?.downloadImageAt(url: url)
	}
}

// MARK: IMainViewController

extension MainViewController: IMainViewController {
	func updateImage() {
		if var view = self.view as? IMainView {
			view.loadingImage = false
		}
		self.tableView.reloadData()
	}
	
	func responseError(error: String) {
		if var view = self.view as? IMainView {
			view.loadingImage = false
		}
		print(error)
	}
}
