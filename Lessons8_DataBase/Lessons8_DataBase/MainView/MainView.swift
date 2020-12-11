//
//  MainView.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 06.12.2020.
//

import UIKit

protocol IMainViewTable {
	func reloadTable()
	func textInCellForRow(at indexPath: IndexPath) -> String?
}

class MainView: UIView {
	private let companiesTable = UITableView()
	private let tableController: IMainViewTableController
	
	private enum Constraints {
		static let companiesTableOffset: CGFloat = 10
	}
	
	init(tableController: IMainViewTableController) {
		self.tableController = tableController
		super.init(frame: .zero)
		
		self.backgroundColor = .white
		self.setupTableAppearance()
		self.configureTable()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MainView {
	func setupTableAppearance() {
		self.companiesTable.backgroundColor = .white
		self.addSubview(self.companiesTable)
		self.companiesTable.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.companiesTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.companiesTableOffset),
			self.companiesTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.companiesTableOffset),
			self.companiesTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.companiesTableOffset),
			self.companiesTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.companiesTableOffset)
		])
	}
	
	func configureTable() {
		self.companiesTable.register(UITableViewCell.self, forCellReuseIdentifier: self.tableController.cellId)
		
		self.companiesTable.delegate = self.tableController.delegate
		self.companiesTable.dataSource = self.tableController.dataSource
	}
}

// MARK: IMainViewTable

extension MainView: IMainViewTable {
	func textInCellForRow(at indexPath: IndexPath) -> String? {
		self.companiesTable.cellForRow(at: indexPath)?.textLabel?.text
	}
	
	func reloadTable() {
		self.companiesTable.reloadData()
	}
}
