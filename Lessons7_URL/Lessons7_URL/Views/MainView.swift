//
//  MainView.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 29.11.2020.
//

import UIKit

protocol IMainView {
	var loadingImage: Bool { get set }
}

class MainView: UIView {
	private let searchString = UISearchBar()
	private let uploadedImage = UIImageView()
	private let activityIndicator = UIActivityIndicatorView(style: .medium)
	private let imageTable: UITableView
	private let delegate : IMainViewUserAction?
	
	private enum Constraints {
		static let searchStringOffset: CGFloat = 10
		static let searchStringHeight: CGFloat = 50
		
		static let uploadedImageHeight: CGFloat = 50
		static let uploadedImageWidth: CGFloat = 50
		static let uploadedImageOffset: CGFloat = 5
		
		static let imageTableOffset: CGFloat = 10
		static let imageTableHeight: CGFloat = 500
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
		self.setupImagesViews()
		self.setupTablesViews()
		
		self.backgroundColor = .white
	}
	
	func setupSearchBarsView() {
		self.searchString.tintColor = .blue
		self.searchString.text = "https://i.ytimg.com/vi/sH4tzJV76YE/hqdefault.jpg"
	}
	
	func setupImagesViews() {
		self.uploadedImage.contentMode = .scaleAspectFit
		self.uploadedImage.image = UIImage(named: "dog")
	}
	
	func setupTablesViews() {
		self.imageTable.backgroundColor = .red
	}
}

// MARK: SetupViewLayout

extension MainView {
	func setupViewLayout() {
		self.setupSearchBarsConstraints()
		self.setupImageViewsConstraints()
		self.setupImageTableConstraints()
		self.setupIndicatorsConstraints()
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
	
	func setupImageViewsConstraints() {
		self.addSubview(self.uploadedImage)
		self.uploadedImage.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.uploadedImage.topAnchor.constraint(equalTo: self.searchString.bottomAnchor, constant: Constraints.uploadedImageOffset),
			self.uploadedImage.heightAnchor.constraint(equalToConstant: Constraints.uploadedImageHeight),
			self.uploadedImage.widthAnchor.constraint(equalToConstant: Constraints.uploadedImageWidth),
			self.uploadedImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
	
	func setupImageTableConstraints() {
		self.addSubview(self.imageTable)
		self.imageTable.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.imageTable.topAnchor.constraint(equalTo: self.uploadedImage.bottomAnchor, constant: Constraints.imageTableOffset),
			self.imageTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 	Constraints.imageTableOffset),
			self.imageTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.imageTableOffset),
			self.imageTable.heightAnchor.constraint(equalToConstant: Constraints.imageTableHeight)
		])
	}
	
	func setupIndicatorsConstraints() {
		self.addSubview(self.activityIndicator)
		self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.activityIndicator.centerXAnchor.constraint(equalTo: self.uploadedImage.centerXAnchor),
			self.activityIndicator.centerYAnchor.constraint(equalTo: self.uploadedImage.centerYAnchor)
		])
	}
}

// MARK: UISearchBarDelegate

extension MainView: UISearchBarDelegate {
	func setupAction() {
		self.setupSearchStringAction()
	}
	
	func setupSearchStringAction() {
		self.searchString.delegate = self
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.endEditing(true)
		self.delegate?.getImageAt(url: self.searchString.text ?? "")
	}
}

// MARK: IMainView

extension MainView: IMainView {
	var loadingImage: Bool {
		get {
			return self.activityIndicator.isAnimating
		}
		set {
			if newValue {
				self.activityIndicator.startAnimating()
			} else {
				self.activityIndicator.stopAnimating()
			}
		}
	}
	

}



