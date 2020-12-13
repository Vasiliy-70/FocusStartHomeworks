//
//  RecipeEditView.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol IRecipeEditView: class {
	func getRecipeInfo() -> [RecipeProperty : String?]
	func showRecipe(info: [RecipeProperty : String?])
}

final class RecipeEditView: UIView {
	private var dishImage = UIImageView(image: UIImage(named: "emptyDish.png"))
	private var nameField = UITextField()
	private var nameLabel = UILabel()
	
	private enum Constraints {
		static let textFieldsOffset: CGFloat = 10
		static let labelsOffset: CGFloat = 10
		static let labelsWidth: CGFloat = 150
	}
	
	init() {
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
		self.setupLabelsView()
		self.setupTextFieldsView()
	}
	
	func setupLabelsView() {
		self.nameLabel.text = "Название: "
		self.nameLabel.numberOfLines = 0
	}
	
	func setupTextFieldsView() {
		self.nameField.borderStyle = .roundedRect
	}
}

// MARK: setupViewConstraints

extension RecipeEditView {
	func setupViewConstraints() {
		self.setupLabelsConstraints()
		self.setupTextFieldsConstraints()
	}
	
	func setupImageConstraints() {
		//self.addSubview(self.dishImage)
		//self.dishImage.translatesAutoresizingMaskIntoConstraints = false
	}
	
	func setupLabelsConstraints() {
		self.addSubview(self.nameLabel)
		self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.labelsOffset),
			self.nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.labelsOffset),
			self.nameLabel.widthAnchor.constraint(equalToConstant: Constraints.labelsWidth)
		])
	}
	
	func setupTextFieldsConstraints() {
		self.addSubview(self.nameField)
		self.nameField.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameField.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor),
			self.nameField.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: Constraints.textFieldsOffset),
			self.nameField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.textFieldsOffset)
		])
	}
}

// MARK:

extension RecipeEditView: IRecipeEditView {
	func getRecipeInfo() -> [RecipeProperty : String?] {
		var info = [RecipeProperty : String?]()
		info[.name] = self.nameField.text
		
		return info
	}
	
	func showRecipe(info: [RecipeProperty : String?]) {
		self.nameField.text = info[.name] ?? ""
	}
}
