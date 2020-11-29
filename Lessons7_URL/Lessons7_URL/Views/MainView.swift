//
//  MainView.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 29.11.2020.
//

import UIKit

class MainView: UIView {
	private let searchString = UISearchBar()
	
	enum Constraints {
		static let searchStringOffset: CGFloat = 10
		static let searchStringHeight: CGFloat = 50
	}
	
	public init() {
		super.init(frame: .zero)
		
		self.setupViewAppearance()
		self.setupViewLayout()
		self.setupAction()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MainView {
	func setupViewAppearance() {
		self.setupSearchBarsView()
		
		self.backgroundColor = .white
	}
	
	func setupSearchBarsView() {
		self.searchString.tintColor = .blue
		self.searchString
	}
}

extension MainView {
	func setupViewLayout() {
		self.setupSearchBarsConstraints()
	}
	
	func setupSearchBarsConstraints() {
		self.addSubview(self.searchString)
		self.searchString.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.searchString.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.searchStringOffset),
			self.searchString.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: Constraints.searchStringOffset),
			self.searchString.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: -Constraints.searchStringOffset),
			self.searchString.heightAnchor.constraint(equalToConstant: Constraints.searchStringHeight)
		])
	}
}

extension MainView: UISearchBarDelegate {
	func setupAction() {
		self.setupSearchStringAction()
	}
	
	func setupSearchStringAction() {
		self.searchString.delegate = self
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		//print(searchBar.text)
		self.endEditing(true)
	}
}
