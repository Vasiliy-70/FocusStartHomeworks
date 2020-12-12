//
//  MainViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import UIKit

protocol IMainViewController: class {
	func updateData()
	var companyName: String? { get }
	var selectedRow: Int? { get }
}

protocol IMainViewTableController: class {
	var cellId: String { get }
	var delegate: UITableViewDelegate { get }
	var dataSource: UITableViewDataSource { get }
}

final class MainViewController: UIViewController {
	var presenter: IMainPresenter?
	private var addCompanyView: UIAlertController?
	private var company: String?
	private var indexRow: Int?
	
	private let cellIdentifier = "cellId"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.configureNavigationBar()
		self.configureAddView()
		self.presenter?.viewDidLoad()
	}
	
	override func loadView() {
		self.view = MainView(tableController: self)
	}
}

//  MARK: ConfigureElements

extension MainViewController {
	func configureNavigationBar() {
		self.navigationItem.rightBarButtonItems = [
			UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.showAddView))
		]
		self.navigationItem.title = "Company List"
	}
	
	func configureAddView() {
		let addViewAlert = 	UIAlertController(title: "Add company",
												 message: "Enter company name",
												 preferredStyle: .alert)
		let saveAction = UIAlertAction(title: "Save", style: .default,
									   handler: {[weak self] _ in
			if let self = self,
			   let name = self.addCompanyView?.textFields?.first?.text,
			   name != "" {
				self.company = name
				
				self.presenter?.actionAlertSave()
				self.addCompanyView?.textFields?.first?.text = ""
			} else {
				let alert = UIAlertController(title: "Error",
											  message: "Invalid data entered",
											  preferredStyle: .alert)
				let applyAction = UIAlertAction(title: "Apply", style: .default,
												handler: {[weak self] _ in
					self?.addCompanyView?.textFields?.first?.text = ""
				})
				
				alert.addAction(applyAction)
				self?.present(alert, animated: true, completion: nil)
			}
		})
		let cancelAction = UIAlertAction(title: "Cancel", style: .default,
										 handler: {[weak self] _ in
			self?.addCompanyView?.textFields?.first?.text = ""
		})
		
		addViewAlert.addTextField(configurationHandler: nil)
		addViewAlert.addAction(saveAction)
		addViewAlert.addAction(cancelAction)
		self.addCompanyView = addViewAlert
	}
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView,
				   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let view = self.view as? IMainViewTable
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
}

// MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter?.companyList.count ?? 0
	}
	
	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier,
												 for: indexPath)
		cell.textLabel?.text = self.presenter?.companyList[indexPath.row]
		return cell
	}
}

// MARK: IMainViewController

extension MainViewController: IMainViewController {
	var selectedRow: Int? {
		self.indexRow
	}
	
	var companyName: String? {
		self.company
	}
	
	func updateData() {
		let view = self.view as? IMainViewTable
		view?.reloadTable()
	}
}

// MARK: IMainViewTableConfigure

extension MainViewController: IMainViewTableController {
	var delegate: UITableViewDelegate {
		self
	}
	
	var dataSource: UITableViewDataSource {
		self
	}
	
	var cellId: String {
		self.cellIdentifier
	}
}

// MARK: Action

extension MainViewController {
	@objc func showAddView() {
		if let addView = self.addCompanyView {
			self.present(addView, animated: true, completion: nil)
		}
	}
}

