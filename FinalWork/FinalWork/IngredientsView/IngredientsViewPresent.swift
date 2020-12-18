//
//  IngredientsViewPresent.swift
//  FinalWork
//
//  Created by Боровик Василий on 16.12.2020.
//

import Foundation

protocol IIngredientsViewPresenter: class {
	var ingredientsList: [String] { get }
	func viewWillAppear()
	func actionCartButtonTabBar()
	func actionEditButtonTabBar()
}

final class IngredientsViewPresenter {
	private weak var view: IIngredientsViewController?
	private var coordinateController: ICoordinateController
	private var queryModel: IQueryService?
	private var recipeID: UUID
	
	private var ingredientsName = [String]() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var ingredientsModel = [Ingredient]() {
		didSet {
			self.ingredientsName.removeAll()
			for ingredient in ingredientsModel {
				if let name = ingredient.name {
					self.ingredientsName.append(name)
				}
			}
		}
	}
	
	public init(view: IIngredientsViewController, coordinateController: ICoordinateController, queryModel: IQueryService, recipeID: UUID) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
		self.recipeID = recipeID
		self.configureNotifications()
	}
}

extension IngredientsViewPresenter {
	func requestData() {
		self.ingredientsModel = self.queryModel?.fetchRequestIngredientsAt(recipeID: self.recipeID) ?? []
	}
}

// MARK: IIngredientsViewPresenter

extension IngredientsViewPresenter: IIngredientsViewPresenter {
	func actionCartButtonTabBar() {
		//self.coordinateController.showRecipeEditViewModalMode(recipeID: self.recipeID)
	}
	
	func actionEditButtonTabBar() {
		self.coordinateController.showIngredientsEditView(recipeID: self.recipeID, modalMode: true)
	}
	
	var ingredientsList: [String] {
		self.ingredientsName
	}

	func viewWillAppear() {
		self.requestData()
	}
}

// MARK: Notification

extension IngredientsViewPresenter {
	func configureNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(self.IngredientEditViewFinished), name: NSNotification.Name(rawValue: "IngredientEditViewFinished"), object: nil)
	}
	
	@objc func IngredientEditViewFinished() {
		self.requestData()
	}
}
