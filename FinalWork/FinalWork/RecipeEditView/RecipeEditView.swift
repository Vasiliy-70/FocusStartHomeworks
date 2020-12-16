//
//  RecipeEditView.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol IRecipeEditView: class {
	func getRecipeInfo() ->  RecipeContent
	func showRecipe(info: RecipeContent)
}

final class RecipeEditView: UIView {
	private let viewController: IRecipeEditViewActionHandler
	
	private var dishImage = UIImageView(image: UIImage(named: "emptyDish.png"))
	private var nameField = UITextField()
	private var nameLabel = UILabel()
	private var descriptionField = UITextView()
	private var descriptionLabel = UILabel()
	
	private enum Constraints {
		static let textFieldsOffset: CGFloat = 10
		static let labelsOffset: CGFloat = 10
		static let imageOffset: CGFloat = 10
		
		static let descriptionFieldHeight: CGFloat = 150
		static let imageHeight: CGFloat = 100
	}
	
	init(viewController: IRecipeEditViewActionHandler) {
		self.viewController = viewController
		super.init(frame: .zero)
		
		self.backgroundColor = .red
		self.setupViewAppearance()
		self.setupViewConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: setupViewAppearance

extension RecipeEditView {
	func setupViewAppearance() {
		self.setupImagesView()
		self.setupLabelsView()
		self.setupTextFieldsView()
	}
	
	func setupImagesView() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapOnImage))
		self.dishImage.isUserInteractionEnabled = true
		self.dishImage.contentMode = .scaleAspectFit
		self.dishImage.addGestureRecognizer(tapGestureRecognizer)
	}
	
	func setupLabelsView() {
		self.nameLabel.text = "Название"
		self.descriptionLabel.text = "Описание"
	}
	
	func setupTextFieldsView() {
		self.nameField.borderStyle = .roundedRect
		
		self.descriptionField.automaticallyAdjustsScrollIndicatorInsets = false
		self.descriptionField.isSelectable = true
		self.descriptionField.isEditable = true
	}
}

// MARK: setupViewConstraints

extension RecipeEditView {
	func setupViewConstraints() {
		self.setupImagesAreaConstraints()
		self.setupNamesAreaConstraints()
		self.setupDescriptionAreaConstraints()
	}

	func setupImagesAreaConstraints() {
		self.addSubview(self.dishImage)
		self.dishImage.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.dishImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.imageOffset),
			self.dishImage.heightAnchor.constraint(equalToConstant: Constraints.imageHeight),
			self.dishImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.imageOffset),
			self.dishImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.imageOffset)
		])
		
	}
	
	func setupNamesAreaConstraints() {
		self.addSubview(self.nameLabel)
		self.addSubview(self.nameField)
	
		self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
		self.nameField.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameLabel.topAnchor.constraint(equalTo: self.dishImage.bottomAnchor, constant: Constraints.labelsOffset),
			self.nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.labelsOffset),
			self.nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.labelsOffset)
		])
		
		NSLayoutConstraint.activate([
			self.nameField.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
			self.nameField.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
			self.nameField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.textFieldsOffset)
		])
	}
	
	func setupDescriptionAreaConstraints() {
		self.addSubview(self.descriptionLabel)
		self.addSubview(self.descriptionField)
		
		self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		self.descriptionField.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.descriptionLabel.topAnchor.constraint(equalTo: self.nameField.bottomAnchor, constant: Constraints.labelsOffset),
			self.descriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.labelsOffset),
			self.descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.labelsOffset)
		])
		
		NSLayoutConstraint.activate([
			self.descriptionField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor),
			self.descriptionField.leadingAnchor.constraint(equalTo: self.descriptionLabel.leadingAnchor),
			self.descriptionField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.textFieldsOffset),
			self.descriptionField.heightAnchor.constraint(equalToConstant: Constraints.descriptionFieldHeight)
		])
	}
}

// MARK: IRecipeEditView

extension RecipeEditView: IRecipeEditView {
	func getRecipeInfo() ->  RecipeContent {
		var info =  RecipeContent()
		info.name = self.nameField.text
		info.definition = self.descriptionField.text
		info.image = self.dishImage.image
		
		return info
	}
	
	func showRecipe(info: RecipeContent) {
		self.nameField.text = info.name ?? ""
		self.descriptionField.text = info.definition ?? ""
		self.dishImage.image = info.image ?? UIImage(named: "emptyDish")
	}
}

// MARK: Action

extension RecipeEditView {
	@objc func tapOnImage() {
		self.viewController.tapOnImage()
	}
}
