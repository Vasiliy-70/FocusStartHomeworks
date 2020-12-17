//
//  RecipeViewPresenter.swift
//  FinalWork
//
//  Created by Боровик Василий on 16.12.2020.
//

import Foundation
import UIKit

protocol IRecipeViewPresenter {
	var recipe: RecipeContent { get }
	func viewWillAppear()
	func actionCartButtonTabBar()
	func actionEditButtonTabBar()
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
			recipeInfo.id = self.recipeID
			recipeInfo.name = newValue.first?.name
			recipeInfo.definition = newValue.first?.definition
			recipeInfo.image = UIImage(data: newValue.first?.image ?? Data())
			recipeInfo.isSelected = newValue.first?.isSelected
		}
	}
	
	init(view: IRecipeViewController, coordinateController: ICoordinateController, queryModel: IQueryService, recipeID: UUID) {
		self.view = view
		self.coordinateController = coordinateController
		self.queryModel = queryModel
		self.recipeID = recipeID
		self.configureNotifications()
	}
}

extension RecipeViewPresenter {
	func requestData() {
		self.recipeModel = self.queryModel.fetchRequestRecipesAt(id: self.recipeID) ?? []
	}
}

// MARK: IRecipeViewPresenter

extension RecipeViewPresenter: IRecipeViewPresenter {
	func actionEditButtonTabBar() {
		self.coordinateController.showRecipeEditViewModalMode(recipeID: self.recipeID)
	}
	
	func actionCartButtonTabBar() {
		if let isSelected = self.recipeInfo.isSelected,
		   isSelected {
			self.recipeInfo.isSelected = false
		} else {
			self.recipeInfo.isSelected = true
		}
		
		self.queryModel.changeRecipe(content: self.recipeInfo)
	}
	
	var recipe: RecipeContent {
		self.recipeInfo
	}
	
	func viewWillAppear() {
		self.requestData()
	}
}

extension RecipeViewPresenter {
	func configureNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(self.recipeEditViewFinished), name: NSNotification.Name(rawValue: "RecipeEditViewFinished"), object: nil)
	}
	
	@objc func recipeEditViewFinished() {
		self.requestData()
	}
}
