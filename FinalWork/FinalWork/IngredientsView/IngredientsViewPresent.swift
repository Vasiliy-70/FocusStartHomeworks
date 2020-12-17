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
	}
}

extension IngredientsViewPresenter {
	func requestData() {
		self.ingredientsModel = self.queryModel?.fetchRequestIngredientsAt(recipeID: self.recipeID) ?? []
	}
}

// MARK: IIngredientsViewPresenter

extension IngredientsViewPresenter: IIngredientsViewPresenter {
	var ingredientsList: [String] {
		self.ingredientsName
	}

	func viewWillAppear() {
		self.requestData()
	}
}
