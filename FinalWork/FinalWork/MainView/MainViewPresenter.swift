//
//  MainViewPresenter.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import Foundation

protocol IMainPresenter: class {
	var recipeList: [String] { get }
	func actionEditRow()
	func actionTapRow()
	func actionDeleteRow()
	func actionAddButton()
	func viewDidLoad()
}

final class MainPresenter {
	private weak var view: IMainViewController?
	private var coordinateController: ICoordinateController
	private var queryModel: IQueryService?
	
	private var recipesName = [String]() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var recipesModel = [Recipe]() {
		didSet {
			self.recipesName.removeAll()
			for recipe in recipesModel {
				if let name = recipe.name {
					self.recipesName.append(name)
				}
			}
		}
	}
	
	public init(view: IMainViewController, coordinateController: ICoordinateController, queryModel: IQueryService) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
	}
}

extension MainPresenter {
	func requestData() {
		self.recipesModel = self.queryModel?.fetchRequestRecipesAt(id: nil) ?? []
	}
}

// MARK: IMainViewController

extension MainPresenter: IMainPresenter {
	var recipeList: [String] {
		self.recipesName
	}
	
	func actionEditRow() {
		if let index = self.view?.selectedRow,
		   let id = self.recipesModel[index].id {
			self.coordinateController.showRecipeEditView(recipeID: id)
		}
	}
	
	func actionTapRow() {
		if let index = self.view?.selectedRow,
		   let id = self.recipesModel[index].id {
			self.coordinateController.showRecipeView(recipeID: id)
		}
	}
	
	func actionDeleteRow() {
		if let index = self.view?.selectedRow,
		   let id = self.recipesModel[index].id {
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
