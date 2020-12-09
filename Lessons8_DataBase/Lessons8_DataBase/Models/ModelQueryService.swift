//
//  ModelQueryService.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import CoreData
import UIKit

extension String: Error {
	
}

protocol IModelQueryService: class {
	func fetchRequest() -> [Company]?
	func add(company name: String, id: String)
	func add(employee name: String, id: String)
	func removeCompany(atId id: UUID)
	func register(observer: IQueueModelObserver, modelType: ModelType)
}

enum ModelType {
	case company
	case employee
}

final class ModelQueryService {
	
	static let manager = ModelQueryService()
	
	private init() {}
	
	lazy var persistContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Lessons8_DataBase")
		container.loadPersistentStores{ (storeDescription, error) in
			if let error = error {
				assertionFailure(error.localizedDescription)
			}
		}
		return container
	}()
	
	private var persistentContainer: NSPersistentContainer?
	weak var mainPresenter: IQueueModelObserver?
	
	private var observers = [(IQueueModelObserver, ModelType)]()

}

extension ModelQueryService {
	func notifyObservers(modelType: ModelType) {
		for observer in self.observers {
			if observer.1 == modelType {
				observer.0.notifierDataUpdate()
			}
		}
	}
}

extension ModelQueryService: IModelQueryService {
	func removeCompany(atId id: UUID) {
		let context = self.persistContainer.viewContext
		let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
		do {
			let companies = try context.fetch(fetchRequest)
			for company in companies {
				if company.id == id {
					context.delete(company)
				}
			}
		} catch let error as NSError {
			assertionFailure(error.description)
		}
		
		self.saveContext()
	}
	
	func register(observer: IQueueModelObserver, modelType: ModelType) {
		self.observers.append((observer, modelType))
	}
	
	func fetchRequest() -> [Company]? {
		var company = [Company]()
		let context = self.persistContainer.viewContext
		let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
		
		do {
			company = try context.fetch(fetchRequest)
		} catch let error as NSError {
			assertionFailure(error.description)
			return nil
		}
		return company
	}
	
	func add(company name: String, id: String) {
		let context = self.persistContainer.viewContext
		guard let entity = NSEntityDescription.entity(forEntityName: "Company", in: context)
		else { assertionFailure("Save error"); return }
		
		let companyObject = Company(entity: entity, insertInto: context)
		companyObject.name = name
		companyObject.id = UUID(uuidString: id)
		
		self.saveContext()
	}
	
	func add(employee name: String, id: String) {
		let context = self.persistContainer.viewContext
		guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
		else { assertionFailure("Save error"); return }
		
		let employeeObject = Employee(entity: entity, insertInto: context)
		employeeObject.name = name
		employeeObject.id = UUID(uuidString: id)
		
		self.saveContext()
	}
	
	func saveContext() {
		let context = self.persistContainer.viewContext
		
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				assertionFailure(error.localizedDescription)
			}
		}
		self.notifyObservers(modelType: .company)
		self.notifyObservers(modelType: .employee)
	}
}
