//
//  MainViewController.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 29.11.2020.
//

import UIKit

protocol IMainViewUserAction: class {
	func startSearchingAt(url: String)
}

protocol IMainViewController: class {
	func show(error: String)
	func updateTable()
}

final class MainViewController: UIViewController {
	
	private var tableView = UITableView()
	private var tableCell = TableCellView()
	private var alertController: UIAlertController?
	private var cellIdentifier = "cellIdentifier"
	
	var presenter: IMainPresenter?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = "Image Search"
		self.configureTable()
		self.configureAlertController()
	}
	
	override func loadView() {
		self.view = MainView(delegate: self, tableView: self.tableView)
	}
}

extension MainViewController {
	func configureTable() {
		self.tableView.register(TableCellView.self, forCellReuseIdentifier: self.cellIdentifier)
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
	}
	
	func configureAlertController() {
		let alertController = UIAlertController(title: "Error", message: "Something wrong", preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default) { (action) in
		}
		alertController.addAction(action)
		self.alertController = alertController
	}
}

// MARK: TableViewDelegate

extension MainViewController:  UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			self.presenter?.removeImageAt(index: indexPath.row)
		}
	}
}

// MARK: TableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.images.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? ITableCell else { assertionFailure("No tableCellView"); return UITableViewCell() }
		cell.newImage = self.presenter?.images[indexPath.row] ?? UIImage()
		cell.imageLoading = self.presenter?.images[indexPath.row] == ImageState.waitingForImage ? true : false
		
		cell.updateContent()
		return cell as? UITableViewCell ?? UITableViewCell()
	}
}

// MARK: IMainViewUserAction

extension MainViewController: IMainViewUserAction {
	func startSearchingAt(url: String) {
		self.presenter?.downloadImageAt(url: url)
	}
}

// MARK: IMainViewController

extension MainViewController: IMainViewController {
	func updateTable() {
		self.tableView.reloadData()
	}
	
	func show(error: String) {
		guard let alertController = self.alertController else { assertionFailure(" No alertController"); return }
		alertController.message = error
		self.present(alertController, animated: true, completion: nil)
	}
}
