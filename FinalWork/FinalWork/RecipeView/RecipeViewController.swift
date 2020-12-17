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
		
		self.configureTabBarController()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.presenter?.viewWillAppear()
	}

	override func loadView() {
		self.view = RecipeView()
	}
}

extension RecipeViewController {
	func configureTabBarController() {
		self.tabBarController?.navigationItem.title = "Просмотр"
		self.title = "Описание"
		self.tabBarItem = UITabBarItem(title: "Описание", image: UIImage(named: "book-simple-7"), selectedImage: nil)
		
		self.tabBarController?.navigationItem.rightBarButtonItems = [
			UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.tabBarCartButtonAction)),
			UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.tabBarEditButtonAction))
		]
	}
	
	@objc func tabBarCartButtonAction() {
		self.presenter?.actionCartButtonTabBar()
	}
	
	@objc func tabBarEditButtonAction() {
		self.presenter?.actionEditButtonTabBar()
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
