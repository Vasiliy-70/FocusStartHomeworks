//
//  MainViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import UIKit

protocol IMainView: class {
	func updateData()
}

class MainViewController: UIViewController {
	
	var presenter: IMainPresenter?
	private var addView: UIAlertController?
	
	private var tableView = UITableView()
	
	private let cellIdentifier = "cellId"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addCompany))
		self.navigationItem.title = "Companies List"
		
		self.configureElements()
		self.presenter?.requestData()
	}
	
	override func loadView() {
		self.view = MainView(table: self.tableView)
	}
	
}

//  MARK: ConfigureElements

extension MainViewController {
	func configureElements() {
		self.configureTable()
		self.configureAddView()
	}
	
	func configureTable() {
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
	}
	
	func configureAddView() {
		let addViewAlert = 	UIAlertController(title: "Add company", message: "Enter company name", preferredStyle: .alert)
		let action = UIAlertAction(title: "Add", style: .default, handler: {[weak self] _ in
			if let self = self {
				self.presenter?.add(company: self.addView?.textFields?.first?.text ?? "undefined")
				self.addView?.textFields?.first?.text = ""
			}
		})
		
		addViewAlert.addTextField(configurationHandler: nil)
		addViewAlert.addAction(action)
		self.addView = addViewAlert
	}
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			if let name = self.tableView.cellForRow(at: indexPath)?.textLabel?.text {
				self.presenter?.remove(company: name, atIndex: indexPath.row)
			}
		}
	}
}

// MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.companiesList.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
		cell.textLabel?.text = self.presenter?.companiesList[indexPath.row]
		return cell
	}
}

// MARK: IMainView

extension MainViewController: IMainView {
	func updateData() {
		self.tableView.reloadData()
	}
}

// MARK: Action

extension MainViewController {
	@objc func addCompany() {
		if let addView = self.addView {
			self.present(addView, animated: true, completion: nil)
		}
	}
}
