//
//  RecipeEditViewAssembly.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

enum RecipeEditViewAssembly{
	static func createRecipeEditViewController(coordinateController: ICoordinateController, queryModel: IQueryService, recipeID: UUID?) -> UIViewController {
		let view = RecipeEditViewController()
		let presenter = RecipeEditViewPresenter(view: view, coordinateController: coordinateController ,queryModel: queryModel, recipeID: recipeID)
		view.presenter = presenter
		return view
	}
}

