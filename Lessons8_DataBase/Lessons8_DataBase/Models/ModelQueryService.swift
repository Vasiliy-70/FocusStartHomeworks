//
//  ModelQueryService.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import CoreData
import UIKit

protocol IModelQueryService: class {
	func fetchRequestCompany() -> [Company]?
	func fetchRequestEmployees(companyID: UUID) -> [Employee]?
	func fetchRequestEmployeeInfo(employeeID: UUID) -> [Employee]?
	func add(company name: String)
	func add(employee info: [EmployeePropertyKey : String?], companyID: UUID)
	func change(employee info: [EmployeePropertyKey : String?], employeeID: UUID)
	func removeCompanyAt(Id id: UUID)
	func removeEmployeeAt(Id id: UUID)
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

// MARK: Notify

extension ModelQueryService {
	func notifyObservers(modelType: ModelType) {
		for observer in self.observers {
			if observer.1 == modelType {
				observer.0.notifierDataUpdate()
			}
		}
	}
}

// MARK: IModelQueryService

extension ModelQueryService: IModelQueryService {
	func register(observer: IQueueModelObserver, modelType: ModelType) {
		self.observers.append((observer, modelType))
	}
	
	func fetchRequestCompany() -> [Company]? {
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
	
	func fetchRequestEmployees(companyID: UUID) -> [Employee]? {
		var employees = [Employee]()
		let context = self.persistContainer.viewContext
		let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
		let predicate = NSPredicate(format: "company.id == %@", companyID as CVarArg)
		fetchRequest.predicate = predicate
		
		do {
			employees = try context.fetch(fetchRequest)
		} catch let error as NSError {
			assertionFailure(error.description)
		}
		return employees
	}
	
	func fetchRequestEmployeeInfo(employeeID: UUID) -> [Employee]? {
		var employees = [Employee]()
		let context = self.persistContainer.viewContext
		let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
		let predicate = NSPredicate(format: "id == %@", employeeID as CVarArg)
		fetchRequest.predicate = predicate
		
		do {
			employees = try context.fetch(fetchRequest)
		} catch let error as NSError {
			assertionFailure(error.description)
		}
		return employees
	}
	
	func change(employee info: [EmployeePropertyKey : String?], employeeID: UUID) {
		if let name = info[.name] as? String,
		   name != "",
		   let age = Int16(info[.age] as? String ?? "none"),
		   age > 0,
		   let experience = Int16(info[.experience] as? String ?? "none"),
		   let education = info[.education] as? String,
		   let position = info[.position] as? String,
		   position != "" {
			
			let context = self.persistContainer.viewContext
			let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
			
			let predicate = NSPredicate(format: "id == %@", employeeID as CVarArg)
			fetchRequest.predicate = predicate
			
			do {
				let employees = try context.fetch(fetchRequest)
				
				employees.first?.name = name
				employees.first?.id = UUID()
				employees.first?.experience = experience
				employees.first?.education = education
				employees.first?.age = age
				employees.first?.position = position
				
				self.saveContext()
			} catch let error as NSError {
				assertionFailure(error.description)
			}
			
		}
	}
	
	func removeCompanyAt(Id id: UUID) {
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
	
	func removeEmployeeAt(Id id: UUID) {
		let context = self.persistContainer.viewContext
		let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
		
		do {
			let employees = try context.fetch(fetchRequest)
			for employee in employees {
				if employee.id == id {
					context.delete(employee)
				}
			}
		} catch let error as NSError {
			assertionFailure(error.description)
		}
		
		self.saveContext()
	}
	
	func add(company name: String) {
		let context = self.persistContainer.viewContext
		guard let entity = NSEntityDescription.entity(forEntityName: "Company", in: context),
			  name != ""
		else { assertionFailure("Save error"); return }
		
		let companyObject = Company(entity: entity, insertInto: context)
		companyObject.name = name
		companyObject.id = UUID()
		
		self.saveContext()
	}
	
	func add(employee info: [EmployeePropertyKey : String?], companyID: UUID) {
		if let name = info[.name] as? String,
		   let age = Int16(info[.age] as? String ?? "none"),
		   let experience = Int16(info[.experience] as? String ?? "none"),
		   let education = info[.education] as? String,
		   let position = info[.position] as? String {
			
			let context = self.persistContainer.viewContext
			let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
			
			guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
			else { assertionFailure("Save error"); return }
			
			let predicate = NSPredicate(format: "id == %@", companyID as CVarArg)
			fetchRequest.predicate = predicate
			
			do {
				let company = try context.fetch(fetchRequest)
				let employeeObject = Employee(entity: entity, insertInto: context)
				
				employeeObject.name = name
				employeeObject.id = UUID()
				employeeObject.experience = experience
				employeeObject.education = education
				employeeObject.age = age
				employeeObject.position = position
				company.first?.addToEmployees(employeeObject)
				
				self.saveContext()
			} catch let error as NSError {
				assertionFailure(error.description)
			}
			
		}
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
