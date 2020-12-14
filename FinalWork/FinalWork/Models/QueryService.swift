//
//  QueryService.swift
//  FinalWork
//
//  Created by Боровик Василий on 13.12.2020.
//

import CoreData
import UIKit

protocol IQueryService {
	func fetchRequestRecipesAt(id: UUID?) -> [Recipe]?
	func addRecipe(info: RecipeContent)
	func removeRecipeAt(id: UUID)
}

struct RecipeContent {
	var name: String?
	var image: UIImage?
}
enum RecipeProperty {
	case name
	case image
}

final class QueryService {
	lazy var persistContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "FinalWork")
		container.loadPersistentStores{ (storeDescription, error) in
			if let error = error {
				assertionFailure(error.localizedDescription)
			}
		}
		return container
	}()
	
	lazy var context: NSManagedObjectContext = {
		let context  = self.persistContainer.viewContext
		return context
	}()
}

extension QueryService {
	func saveContext() {
		if self.context.hasChanges {
			do {
				try self.context.save()
			} catch {
				assertionFailure(error.localizedDescription)
			}
		}
	}
}

// MARK: IQueryService

extension QueryService: IQueryService {

	func removeRecipeAt(id: UUID) {
		let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		
		do {
			let recipes = try self.context.fetch(fetchRequest)
			for recipe in recipes {
				if recipe.id == id {
					self.context.delete(recipe)
				}
			}
		} catch {
			assertionFailure(error.localizedDescription)
		}
		
		self.saveContext()
	}
	
	func fetchRequestRecipesAt(id: UUID?) -> [Recipe]? {
		var recipe = [Recipe]()
		let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		
		if let id = id {
			let predicate = NSPredicate(format: "id==%@", id as CVarArg )
			fetchRequest.predicate = predicate
		}
		
		do {
			recipe = try self.context.fetch(fetchRequest)
		} catch let error as NSError {
			assertionFailure(error.localizedDescription)
			return nil
		}
		return recipe
	}
	
	func addRecipe(info: RecipeContent) {
		guard info.name != "",
			  let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: self.context)
		else {
			assertionFailure("Save error")
			return
		}
		
		let recipe = Recipe(entity: entity, insertInto: self.context)
		recipe.name = info.name
		recipe.image = info.image?.pngData()
		recipe.id = UUID()
		
		self.saveContext()
	}
}


