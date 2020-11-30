//
//  MainView.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 29.11.2020.
//

import UIKit

class MainView: UIView {
	private let searchString = UISearchBar()
	private let uploadedImage = UIImageView()
	private let queryService = QueryService()
	
	private enum Constraints {
		static let searchStringOffset: CGFloat = 10
		static let searchStringHeight: CGFloat = 50
		
		static let uploadedImageHeight: CGFloat = 300
		static let uploadedImageWidth: CGFloat = 250
		static let uploadedImageOffset: CGFloat = 10
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
		self.setupImageViews();
		
		self.backgroundColor = .white
	}
	
	func setupSearchBarsView() {
		self.searchString.tintColor = .blue
		self.searchString.text = "https://i.ytimg.com/vi/sH4tzJV76YE/hqdefault.jpg"
	}
	
	func setupImageViews() {
		self.uploadedImage.contentMode = .scaleAspectFit
		self.uploadedImage.image = UIImage(named: "dog")
	}
}

extension MainView {
	func setupViewLayout() {
		self.setupSearchBarsConstraints()
		self.setupImageViewsConstraints()
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
}

extension MainView: UISearchBarDelegate {
	func setupAction() {
		self.setupSearchStringAction()
	}
	
	func setupSearchStringAction() {
		self.searchString.delegate = self
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.endEditing(true)
		
		self.queryService.getSearchResults(url: self.searchString.text ?? "", completion: {image, error in
			self.uploadedImage.image = UIImage(data: image)
		})
	}
}
