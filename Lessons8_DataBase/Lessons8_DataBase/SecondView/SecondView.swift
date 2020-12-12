//
//  SecondView.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

protocol ISecondViewTable {
	func reloadTable()
	func textInCellForRow(at indexPath: IndexPath) -> String?
}

final class SecondView: UIView {
	private let employeesTable = UITableView()
	private let tableController: ISecondViewTableController
	
	private enum Constraints {
		static let tableViewOffset: CGFloat = 10
	}
	
	init(tableController: ISecondViewTableController) {
		self.tableController = tableController
		super.init(frame: .zero)
		
		self.backgroundColor = .white
		self.configureTable()
		self.setupTableAppearance()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SecondView {
	func setupTableAppearance() {
		self.employeesTable.backgroundColor = .white
		self.addSubview(self.employeesTable)
		self.employeesTable.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.employeesTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.tableViewOffset),
			self.employeesTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.tableViewOffset),
			self.employeesTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.tableViewOffset),
			self.employeesTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.tableViewOffset)
		])
	}
	
	func configureTable() {
		self.employeesTable.register(UITableViewCell.self, forCellReuseIdentifier: self.tableController.cellId)
		
		self.employeesTable.delegate = self.tableController.delegate
		self.employeesTable.dataSource = self.tableController.dataSource
	}
}

// MARK: ISecondViewTable

extension SecondView: ISecondViewTable {
	func textInCellForRow(at indexPath: IndexPath) -> String? {
		self.employeesTable.cellForRow(at: indexPath)?.textLabel?.text
	}
	
	func reloadTable() {
		self.employeesTable.reloadData()
	}
}
