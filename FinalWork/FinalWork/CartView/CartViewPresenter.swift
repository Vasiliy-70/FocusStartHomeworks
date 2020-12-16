//
//  CartViewPresenter.swift
//  FinalWork
//
//  Created by Боровик Василий on 16.12.2020.
//

import Foundation

protocol ICartViewPresenter: class {
	var ingredientsList: [String] { get }
	func viewDidLoad()
}

final class CartViewPresenter {
	private weak var view: ICartViewController?
	private var coordinateController: ICoordinateController
	private var queryModel: IQueryService?
	
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
	
	public init(view: ICartViewController, coordinateController: ICoordinateController, queryModel: IQueryService) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
	}
}

extension CartViewPresenter {
	func requestData() {
		self.ingredientsModel = []
		let selectedRecipes = self.queryModel?.fetchRequestSelectedRecipes() ?? []
		for recipe in selectedRecipes {
			if let recipeID = recipe.id {
				self.ingredientsModel += self.queryModel?.fetchRequestIngredientsAt(recipeID: recipeID) ?? []
			}
		}
		
	}
}

// MARK: ICartViewPresenter

extension CartViewPresenter: ICartViewPresenter {
	var ingredientsList: [String] {
		self.ingredientsName
	}

	func viewDidLoad() {
		self.requestData()
	}
}
