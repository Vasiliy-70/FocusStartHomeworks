//
//  IngredientsEditViewPresenter.swift
//  FinalWork
//
//  Created by Боровик Василий on 15.12.2020.
//

import CoreData
import UIKit

protocol IIngredientsEditViewPresenter: class {
	var ingredientList: [String] { get }
	func actionEditRow()
	func actionDeleteRow()
	func actionApplyButton()
	func actionAddButton()
	func actionEditCellAlert(newName: String)
	func viewDidLoad()
}

final class IngredientsEditViewPresenter {
	private weak var view: IIngredientsEditViewController?
	private var coordinateController: ICoordinateController
	private var queryModel: IQueryService?
	private var recipeID: UUID
	private var isNewIngredientEdit = false
	
	private var ingredientName = [String]() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var ingredientModel = [Ingredient]() {
		didSet {
			self.ingredientName.removeAll()
			for ingredient in ingredientModel {
				if let name = ingredient.name {
					self.ingredientName.append(name)
				}
			}
		}
	}
	
	public init(view: IngredientsEditViewController, coordinateController: ICoordinateController, queryModel: IQueryService, recipeID: UUID) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
		self.recipeID = recipeID
	}
}

extension IngredientsEditViewPresenter {
	func requestData() {
		self.ingredientModel = self.queryModel?.fetchRequestIngredientsAt(recipeID: self.recipeID) ?? []
	}
}

// MARK: IMainViewController

extension IngredientsEditViewPresenter: IIngredientsEditViewPresenter {
	func actionEditCellAlert(newName: String) {
		var ingredient = IngredientContent()
		ingredient.name = newName
		if self.isNewIngredientEdit {
			self.queryModel?.addIngredient(info: ingredient, recipeID: self.recipeID)
		} else {
			if let index = self.view?.selectedRow {
				ingredient.id = self.ingredientModel[index].id
				self.queryModel?.changeIngredient(content: ingredient)
			}
		}
		self.requestData()
	}
	
	func actionApplyButton() {
		(self.view as? UIViewController)?.navigationController?.popToRootViewController(animated: true)
	}
	
	var ingredientList: [String] {
		self.ingredientName
	}
	
	func actionEditRow() {
		self.isNewIngredientEdit = false
		if let index = self.view?.selectedRow {
			let ingredientName = self.ingredientName[index]
			self.view?.showAlertIngredients(title: "Имя ингредиента", message: "Введите новое значение", textValue: ingredientName)
		}
		/*if let index = self.view?.selectedRow,
		   let id = self.ingredientModel[index].id {
			self.coordinateController.showRecipeEditView(recipeID: id)
		}*/
	}
	
	func actionDeleteRow() {
		if let index = self.view?.selectedRow,
		   let id = self.ingredientModel[index].id {
			self.queryModel?.removeIngredientAt(id: id)
			self.requestData()
		}
	} 
	
	func actionAddButton() {
		self.isNewIngredientEdit = true
		self.view?.showAlertIngredients(title: "Имя ингредиента", message: "Введите новое значение", textValue: "")
	}
	
	func viewDidLoad() {
		self.requestData()
	}
}

