//
//  MainView.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 29.11.2020.
//

import UIKit

final class MainView: UIView {
	private let searchString = UISearchBar()
	private let imageTable: UITableView
	
	private let delegate : IMainViewUserAction?
	
	private enum Constraints {
		static let searchStringOffset: CGFloat = 10
		static let imageTableOffset: CGFloat = 10
	}
	
	public init(delegate: IMainViewUserAction, tableView: UITableView) {
		self.imageTable = tableView
		self.delegate = delegate
		super.init(frame: .zero)
		
		self.setupViewAppearance()
		self.setupViewLayout()
		self.setupAction()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: SetupViewAppearance

extension MainView {
	func setupViewAppearance() {
		self.setupSearchBarsView()
		self.setupTablesViews()
		
		self.backgroundColor = .white
		self.layoutSubviews()
	}
	
	func setupSearchBarsView() {
		self.searchString.tintColor = .blue
		self.searchString.placeholder = "Input URL here"
	}
		
	func setupTablesViews() {
		self.imageTable.backgroundColor = .white
	}
}

// MARK: SetupViewLayout

extension MainView {
	func setupViewLayout() {
		self.setupSearchBarsConstraints()
		self.setupImageTableConstraints()
	}
	
	func setupSearchBarsConstraints() {
		self.addSubview(self.searchString)
		self.searchString.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.searchString.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.searchStringOffset),
			self.searchString.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Constraints.searchStringOffset),
			self.searchString.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: -Constraints.searchStringOffset)
		])
	}

	func setupImageTableConstraints() {
		self.addSubview(self.imageTable)
		self.imageTable.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.imageTable.topAnchor.constraint(equalTo: self.searchString.bottomAnchor, constant: Constraints.imageTableOffset),
			self.imageTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 	Constraints.imageTableOffset),
			self.imageTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.imageTableOffset),
			self.imageTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

// MARK: Action

extension MainView {
	func setupAction() {
		self.setupSearchStringAction()
		self.hideKeyboardWhenTappedAround()
	}
	
	func hideKeyboardWhenTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
		tap.cancelsTouchesInView = false
		self.addGestureRecognizer(tap)
	}
	
	@objc func hideKeyboard() {
		self.endEditing(true)
	}
}

// MARK: UISearchBarDelegate

extension MainView: UISearchBarDelegate {
	func setupSearchStringAction() {
		self.searchString.delegate = self
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.hideKeyboard()
		self.delegate?.startSearchingAt(url: self.searchString.text ?? "")
	}
}



