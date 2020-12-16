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
	func actionAlertIngredients()
	func cancelAlertIngredients()
	func viewDidLoad()
}

final class RecipeEditViewPresenter {
	weak var view: IRecipeEditViewController?
	private let coordinateController: ICoordinateController
	private let queryModel: IQueryService
	private var recipeID: UUID?
	
	private var recipeInfo = RecipeContent() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var recipeModel = [Recipe]() {
		willSet {
			self.recipeInfo.id = newValue.first?.id
			self.recipeInfo.name = newValue.first?.name
			self.recipeInfo.definition = newValue.first?.definition
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
		if var recipe = self.view?.recipe {
			if self.view?.recipe.id != nil {
				self.queryModel.changeRecipe(content: recipe)
			} else {
				self.recipeID = UUID()
				recipe.id = self.recipeID
				self.queryModel.addRecipe(info: recipe)
			}
			self.requestData()
			self.view?.showAlertIngredients()
		}
	}
	
	func actionAlertIngredients() {
		if let id = self.recipeInfo.id {
			self.coordinateController.showIngredientsEditView(recipeID: id)
		}
	}
	
	func cancelAlertIngredients() {
		//self.coordinateController.showMainView()
		if let view = self.view as? UIViewController {
			view.navigationController?.popToRootViewController(animated: true)
		}
	
	}
	
	func viewDidLoad() {
		self.requestData()
	}
}
