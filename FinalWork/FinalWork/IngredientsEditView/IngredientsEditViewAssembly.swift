//
//  IngredientsEditViewAssembly.swift
//  FinalWork
//
//  Created by Боровик Василий on 15.12.2020.
//

import UIKit

enum IngredientsEditViewAssembly {
	static func createIngredientsEditView(coordinateController: ICoordinateController, queryModel: IQueryService, recipeID: UUID) -> UIViewController {
		let view = IngredientsEditViewController()
		let presenter = IngredientsEditViewPresenter(view: view, coordinateController: coordinateController, queryModel: queryModel, recipeID: recipeID)
		view.presenter = presenter
		return view
	}
}
