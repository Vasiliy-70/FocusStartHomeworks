//
//  RecipeViewController.swift
//  FinalWork
//
//  Created by Боровик Василий on 16.12.2020.
//

import UIKit

protocol IRecipeViewController: class {
	func updateData()
}

final class RecipeViewController: UIViewController {
	var presenter: IRecipeViewPresenter?
	var recipeInfo = RecipeContent()
	
    override func viewDidLoad() {
        super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.viewWillAppear()
	}
	
	override func loadView() {
		self.view = RecipeView()
	}

}

// MARK: IRecipeViewController

extension RecipeViewController: IRecipeViewController {
	func updateData() {
		if let recipe = self.presenter?.recipe {
			self.recipeInfo = recipe
		}
		(self.view as? IRecipeView)?.showRecipe(info: self.recipeInfo)
	}
}
