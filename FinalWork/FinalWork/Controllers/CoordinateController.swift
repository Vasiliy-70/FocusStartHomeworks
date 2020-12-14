//
//  CoordinateController.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol ICoordinateController: class {
	func showRecipeEditView(recipeID: UUID?)
	func showIngredientsEditView(recipeID: UUID?)
}

final class CoordinateController {
	private var navigationController: UINavigationController?
	private var queryModel = QueryService()
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension CoordinateController {
	func initialStartViewController() {
		guard let navigationController = self.navigationController
		else {
			assertionFailure("Error init start VC")
			return
		}
		let mainViewController = MainViewAssembly.createMainViewController(coordinateController: self, queryModel: self.queryModel)
		navigationController.viewControllers = [mainViewController]
	}
}

// MARK: ICoordinateController

extension CoordinateController: ICoordinateController {
	func showIngredientsEditView(recipeID: UUID?) {
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
}
