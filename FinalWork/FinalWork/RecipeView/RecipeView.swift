//
//  RecipeView.swift
//  FinalWork
//
//  Created by Боровик Василий on 15.12.2020.
//

import UIKit

protocol IRecipeView: class {
	func showRecipe(info: RecipeContent)
}

final class RecipeView: UIView {
	private var recipeImage = UIImageView()
	private var nameLabel =  UILabel()
	private var descriptionLabel = UILabel()
	
	private enum Constraints {
		static let recipeImageOffset: CGFloat = 0
		static let recipeImageHeight: CGFloat = 300
		
		static let labelsOffset: CGFloat = 10
		static let nameLabelHeight: CGFloat = 50
	}
	
	init() {
		super.init(frame: .zero)
		
		self.backgroundColor = .blue
		self.setupImageView()
		self.setupLabelView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension RecipeView {
	func setupImageView() {
		self.recipeImage.contentMode = .scaleToFill
		
		self.addSubview(self.recipeImage)
		self.recipeImage.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.recipeImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.recipeImageOffset),
			self.recipeImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.recipeImageOffset),
			self.recipeImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.recipeImageOffset),
			self.recipeImage.heightAnchor.constraint(equalToConstant: Constraints.recipeImageHeight)
		])
	}
	
	func setupLabelView() {
		self.nameLabel.backgroundColor = .black
		self.nameLabel.textColor = .white
		self.nameLabel.textAlignment = .left
		self.nameLabel.alpha = 0.4
		
		self.recipeImage.addSubview(self.nameLabel)
		self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameLabel.bottomAnchor.constraint(equalTo: self.recipeImage.bottomAnchor),
			self.nameLabel.leadingAnchor.constraint(equalTo: self.recipeImage.leadingAnchor),
			self.nameLabel.trailingAnchor.constraint(equalTo: self.recipeImage.trailingAnchor),
			self.nameLabel.heightAnchor.constraint(equalToConstant: Constraints.nameLabelHeight)
		])
	}
}

// MARK: IRecipeView

extension RecipeView: IRecipeView {
	func showRecipe(info: RecipeContent) {
		self.nameLabel.text = info.name
		self.recipeImage.image = info.image ?? UIImage()
	}
}
