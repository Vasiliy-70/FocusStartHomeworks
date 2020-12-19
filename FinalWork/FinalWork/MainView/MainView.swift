//
//  MainView.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol IMainView {
	func reloadTable()
	func textInCellForRow(at indexPath: IndexPath) -> String?
}

class MainView: UIView {
	private let recipesTable = UITableView()
	private let tableController: IMainViewTableController
	
	private enum Constraints {
		static let recipesTableOffset: CGFloat = 10
	}
	
	init(tableController: IMainViewTableController) {
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

extension MainView {
	func configureTable() {
		self.recipesTable.register(MainViewTableCell.self, forCellReuseIdentifier: self.tableController.cellId)
		
		self.recipesTable.delegate = self.tableController.delegate
		self.recipesTable.dataSource = self.tableController.dataSource
	}
	
	func setupTableAppearance() {
		self.recipesTable.backgroundColor = .white
		self.addSubview(self.recipesTable)
		self.recipesTable.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.recipesTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.recipesTableOffset),
			self.recipesTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.recipesTableOffset),
			self.recipesTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.recipesTableOffset),
			self.recipesTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.recipesTableOffset)
		])
	}
}

// MARK: IMainView

extension MainView: IMainView {
	func reloadTable() {
		self.recipesTable.reloadData()
	}
	
	func textInCellForRow(at indexPath: IndexPath) -> String? {
		let cell = self.recipesTable.cellForRow(at: indexPath)
		return (cell as? IMainViewTableCell)?.title
	}
}

