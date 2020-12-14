//
//  RecipeEditViewPresenter.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol IRecipeEditViewPresenter {
	var recipe: RecipeContent { get }
	func actionSaveButton()
	func viewDidLoad()
}

final class RecipeEditViewPresenter {
	weak var view: IRecipeEditViewController?
	private let queryModel: IQueryService
	private let recipeID: UUID?
	
	private var recipeInfo = RecipeContent() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var recipeModel = [Recipe]() {
		willSet {
			self.recipeInfo.name = newValue.first?.name
			self.recipeInfo.image = UIImage(data: newValue.first?.image ?? Data())
		}
	}
	
	public init (view: IRecipeEditViewController, queryModel: IQueryService, recipeID: UUID?) {
		self.view = view
		self.queryModel = queryModel
		self.recipeID = recipeID
	}
}

extension RecipeEditViewPresenter {
	func requestData() {
		if self.recipeID != nil {
			self.recipeModel = self.queryModel.fetchRequestRecipesAt(id: self.recipeID) ?? []
		}
	}
}

// MARK: IRecipeEditPresenter

extension RecipeEditViewPresenter: IRecipeEditViewPresenter {
	var recipe: RecipeContent {
		self.recipeInfo
	}
	
	func actionSaveButton() {
		if let recipe = self.view?.recipe {
			self.queryModel.addRecipe(info: recipe)
		}
		
		let view = self.view as? UIViewController
		view?.navigationController?.popViewController(animated: true)
	}
	
	func viewDidLoad() {
		self.requestData()
	}
}
