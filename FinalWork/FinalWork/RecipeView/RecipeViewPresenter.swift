//
//  RecipeViewPresenter.swift
//  FinalWork
//
//  Created by Боровик Василий on 16.12.2020.
//

import UIKit

protocol IRecipeViewPresenter {
	var recipe: RecipeContent { get }
	func viewWillAppear()
}

final class RecipeViewPresenter {
	private var view: IRecipeViewController
	private var coordinateController: ICoordinateController
	private var queryModel: IQueryService
	private var recipeID: UUID
	
	private var recipeInfo = RecipeContent() {
		didSet {
			self.view.updateData()
		}
	}
	
	private var recipeModel = [Recipe]() {
		willSet {
			recipeInfo = RecipeContent()
			recipeInfo.name = newValue.first?.name
			recipeInfo.definition = newValue.first?.definition
			recipeInfo.image = UIImage(data: newValue.first?.image ?? Data())
		}
	}
	
	init(view: IRecipeViewController, coordinateController: ICoordinateController, queryModel: IQueryService, recipeID: UUID) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
		self.recipeID = recipeID
	}
}

extension RecipeViewPresenter {
	func requestData() {
		self.recipeModel = self.queryModel.fetchRequestRecipesAt(id: self.recipeID) ?? []
	}
}

// MARK: IRecipeViewPresenter

extension RecipeViewPresenter: IRecipeViewPresenter {
	var recipe: RecipeContent {
		self.recipeInfo
	}
	
	func viewWillAppear() {
		self.requestData()
	}
}
