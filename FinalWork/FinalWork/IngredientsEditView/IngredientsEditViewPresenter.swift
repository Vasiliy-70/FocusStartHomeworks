//
//  IngredientsEditViewPresenter.swift
//  FinalWork
//
//  Created by Боровик Василий on 15.12.2020.
//

protocol IIngredientsEditViewPresenter: class {
	var ingredientList: [String] { get }
	func actionEditRow()
	func actionTapRow()
	func actionDeleteRow()
	func actionAddButton()
	func viewDidLoad()
}

final class IngredientsEditViewPresenter {
	private weak var view: IIngredientsEditViewController?
	private var coordinateController: ICoordinateController
	private var queryModel: IQueryService?
	
	private var ingredientName = [String]() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var ingredientModel = [Recipe]() {
		didSet {
			self.ingredientName.removeAll()
			for recipe in ingredientModel {
				if let name = recipe.name {
					self.ingredientName.append(name)
				}
			}
		}
	}
	
	public init(view: IngredientsEditViewController, coordinateController: ICoordinateController, queryModel: IQueryService) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
	}
}

extension IngredientsEditViewPresenter {
	func requestData() {
		self.ingredientModel = self.queryModel?.fetchRequestRecipesAt(id: nil) ?? []
	}
}

// MARK: IMainViewController

extension IngredientsEditViewPresenter: IIngredientsEditViewPresenter {
	var ingredientList: [String] {
		self.ingredientName
	}
	
	func actionEditRow() {
		if let index = self.view?.selectedRow,
		   let id = self.ingredientModel[index].id {
//			self.coordinateController.showRecipeEditView(recipeID: id)
		}
	}
	
	func actionTapRow() {
		//
	}
	
	func actionDeleteRow() {
		if let index = self.view?.selectedRow,
		   let id = self.ingredientModel[index].id {
			self.queryModel?.removeRecipeAt(id: id)
			self.requestData()
		}
	}
	
	func actionAddButton() {
		self.coordinateController.showRecipeEditView(recipeID: nil)
	}
	
	func viewDidLoad() {
		self.requestData()
	}
}

