//
//  SecondView.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

class SecondView: UIView {
	private var userTable: UITableView
	
	private enum Constraints {
		static let tableViewOffset: CGFloat = 10
	}
	
	init(tableView: UITableView) {
		self.userTable = tableView
		super.init(frame: .zero)
		
		self.backgroundColor = .white
		self.setupTableAppearance()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SecondView {
	func setupTableAppearance() {
		self.userTable.backgroundColor = .white
		self.addSubview(self.userTable)
		self.userTable.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.userTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.tableViewOffset),
			self.userTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.tableViewOffset),
			self.userTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.tableViewOffset),
			self.userTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.tableViewOffset)
			
		])
	}
}
