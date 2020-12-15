//
//  CoordinateController.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol ICoordinateController: class {
	func showMainView()
	func showRecipeEditView(recipeID: UUID?)
	func showIngredientsEditView(recipeID: UUID)
	func showRecipeView(recipeID: UUID)
}

final class CoordinateController {
	private var navigationController: UINavigationController?
	private var queryModel = QueryService()
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

// MARK: ICoordinateController

extension CoordinateController: ICoordinateController {
	func showMainView() {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init start VC")
			return
		}
		let mainViewController = MainViewAssembly.createMainViewController(coordinateController: self, queryModel: self.queryModel)
		navigationController.viewControllers = [mainViewController]
	}
	
	func showIngredientsEditView(recipeID: UUID) {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error show IngredientsEditView")
			return
		}
		let ingredientsEditView = IngredientsEditViewAssembly.createIngredientsEditView(coordinateController: self, queryModel: self.queryModel, recipeID: recipeID)
		navigationController.pushViewController(ingredientsEditView, animated: true)
	}
	
	func showRecipeEditView(recipeID: UUID?) {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error show RecipeEditView")
			return
		}
		let recipeEditView = RecipeEditViewAssembly.createRecipeEditViewController(coordinateController: self,queryModel: self.queryModel, recipeID: recipeID)
		navigationController.pushViewController(recipeEditView, animated: true)
	}
	
	func showRecipeView(recipeID: UUID) {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error show RecipeView")
			return
		}
		
		let recipeView = RecipeViewAssembly.createRecipeView(coordinateController: self, queryModel: queryModel, recipeID: recipeID)
		navigationController.pushViewController(recipeView, animated: true)
	}
}
