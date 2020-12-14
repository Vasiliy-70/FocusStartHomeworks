//
//  RecipeEditViewController.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import UIKit

protocol IRecipeEditViewController: class {
	var recipe: RecipeContent { get }
	func updateData()
}

protocol IRecipeEditViewActionHandler: class {
	func tapOnImage()
}

final class RecipeEditViewController: UIViewController {
	var presenter: IRecipeEditViewPresenter?
	private var recipeInfo = RecipeContent() {
		willSet {
			self.navigationItem.title = newValue.id != nil ?
				"Редактирование рецепта" : "Создание рецепта"
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.configureNavigationBar()
		self.presenter?.viewDidLoad()
    }
	
	override func loadView() {
		self.view = RecipeEditView(viewController: self)
	}
}

extension RecipeEditViewController {
	func configureNavigationBar() {
		self.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.actionSaveButton))]
	}
}

// MARK: IRecipeEditViewController

extension RecipeEditViewController: IRecipeEditViewController {
	var recipe: RecipeContent {
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
			self.recipeInfo.name = view.getRecipeInfo().name
			self.recipeInfo.image = view.getRecipeInfo().image
			self.presenter?.actionSaveButton()
		}
	}
	
	func presentImageViewPicker(sender: AnyObject) {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		imagePicker.allowsEditing = false
		
		self.present(imagePicker, animated: true, completion: nil)
	}
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension RecipeEditViewController:  UIImagePickerControllerDelegate,
									 UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController,
							   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[.originalImage] as? UIImage {
			self.recipeInfo.image = image
			(self.view as? IRecipeEditView)?.showRecipe(info: self.recipeInfo)
			self.navigationController?.dismiss(animated: true, completion: nil)
		}
	}
}

// MARK: IRecipeEditViewActionHandler

extension RecipeEditViewController: IRecipeEditViewActionHandler {
	func tapOnImage() {
		self.presentImageViewPicker(sender: self)
	}
}
 
