//
//  RecipeEditViewController.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol IRecipeEditViewController: class {
	var recipe: [RecipeProperty : String?] { get }
	func updateData()
}

final class RecipeEditViewController: UIViewController {
	var presenter: IRecipeEditViewPresenter?
	private var recipeInfo = [RecipeProperty : String?]()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.configureNavigationBar()
		self.presenter?.viewDidLoad()
    }
	
	override func loadView() {
		self.view = RecipeEditView()
	}
}

extension RecipeEditViewController {
	func configureNavigationBar() {
		self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.actionSaveButton))]
		self.navigationItem.title = "Редактирование рецепта"
	}
}

// MARK: IRecipeEditViewController

extension RecipeEditViewController: IRecipeEditViewController {
	var recipe: [RecipeProperty : String?] {
		self.recipeInfo
	}
	
	func updateData() {
		if let recipe = self.presenter?.recipe {
			self.recipeInfo = recipe
			let view = self.view as? IRecipeEditView
			view?.showRecipe(info: self.recipeInfo)
		}
	}
}


// MARK: Action

extension RecipeEditViewController {
	@objc func actionSaveButton() {
		if let view = self.view as? IRecipeEditView {
			self.recipeInfo = view.getRecipeInfo()
			self.presenter?.actionSaveButton()
		}
	}
}
