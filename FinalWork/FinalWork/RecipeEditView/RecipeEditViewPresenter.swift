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
	private let coordinateController: ICoordinateController
	private let queryModel: IQueryService
	private let recipeID: UUID?
	
	private var recipeInfo = RecipeContent() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var recipeModel = [Recipe]() {
		willSet {
			self.recipeInfo.id = newValue.first?.id
			self.recipeInfo.name = newValue.first?.name
			self.recipeInfo.image = UIImage(data: newValue.first?.image ?? Data())
		}
	}
	
	public init (view: IRecipeEditViewController, coordinateController: ICoordinateController, queryModel: IQueryService, recipeID: UUID?) {
		self.view = view
		self.queryModel = queryModel
		self.recipeID = recipeID
		self.coordinateController = coordinateController
	}
}

extension RecipeEditViewPresenter {
	func requestData() {
		if self.recipeID != nil {
			self.recipeModel = self.queryModel.fetchRequestRecipesAt(id: self.recipeID) ?? []
		} else {
			self.recipeInfo = RecipeContent()
		}
	}
}

// MARK: IRecipeEditPresenter

extension RecipeEditViewPresenter: IRecipeEditViewPresenter {
	var recipe: RecipeContent {
		self.recipeInfo
	}
	
	func actionSaveButton() {
//		if let recipe = self.view?.recipe {
//			if self.view?.recipe.id != nil {
//				self.queryModel.changeRecipe(content: recipe)
//			} else {
//				self.queryModel.addRecipe(info: recipe)
//			}
//		}
//
//		let view = self.view as? UIViewController
//		view?.navigationController?.popViewController(animated: true)
		self.coordinateController.showIngredientsEditView(recipeID: self.recipeInfo.id)
	}
	
	func viewDidLoad() {
		self.requestData()
	}
}
