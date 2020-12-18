//
//  MainViewPresenter.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol IMainViewPresenter: class {
	var recipeList: [RecipeContent] { get }
	func actionTapRow()
	func actionDeleteRow()
	func actionAddButton()
	func viewDidLoad()
	func actionLeftSwipe()
}

final class MainViewPresenter {
	private weak var view: IMainViewController?
	private var coordinateController: ICoordinateController
	private var queryModel: IQueryService?
	
	private var recipesInfo = [RecipeContent]() {
		didSet {
			self.view?.updateData()
		}
	}
	
	private var recipesModel = [Recipe]() {
		didSet {
			self.recipesInfo.removeAll()
			for recipe in recipesModel {
				var recipeContent = RecipeContent()
				recipeContent.id = recipe.id
				recipeContent.name = recipe.name
				recipeContent.image = UIImage(data: recipe.image ?? Data())
				recipeContent.isSelected = recipe.isSelected
				
				self.recipesInfo.append(recipeContent)
			}
		}
	}
	
	public init(view: IMainViewController, coordinateController: ICoordinateController, queryModel: IQueryService) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
		self.configureNotifications()
	}
}

extension MainViewPresenter {
	func requestData() {
		self.recipesModel = self.queryModel?.fetchRequestRecipesAt(id: nil) ?? []
	}
}

// MARK: IMainPresenter

extension MainViewPresenter: IMainViewPresenter {
	func actionLeftSwipe() {
		(self.view as? UIViewController)?.tabBarController?.selectedIndex = 1
	}
	
	var recipeList: [RecipeContent] {
		self.recipesInfo
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


// MARK: Notification

extension MainViewPresenter {
	func configureNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(self.recipeEditViewFinished), name: NSNotification.Name(rawValue: "RecipeEditViewFinished"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.recipeEditViewFinished), name: NSNotification.Name(rawValue: "RecipeEditViewFinishedNoModal"), object: nil)
	}
	
	@objc func recipeEditViewFinished() {
		self.requestData()
	}
}
