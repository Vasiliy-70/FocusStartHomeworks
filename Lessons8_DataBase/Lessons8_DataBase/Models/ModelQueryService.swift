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
	func removeCompanyAt(id: UUID)
	func removeEmployeeAt(id: UUID)
}

enum EmployeePropertyKey {
	case name
	case age
	case experience
	case education
	case position
}

final class ModelQueryService {
	
	lazy var persistContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Lessons8_DataBase")
		container.loadPersistentStores{ (storeDescription, error) in
			if let error = error {
				assertionFailure(error.localizedDescription)
			}
		}
		return container
	}()
	
	lazy var context: NSManagedObjectContext = {
		let context = self.persistContainer.viewContext
		return context
	}()
}

// MARK: IModelQueryService

extension ModelQueryService: IModelQueryService {
	func fetchRequestCompany() -> [Company]? {
		var company = [Company]()
		let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
		
		do {
			company = try self.context.fetch(fetchRequest)
		} catch let error as NSError {
			assertionFailure(error.description)
			return nil
		}
		return company
	}
	
	func fetchRequestEmployees(companyID: UUID) -> [Employee]? {
		var employees = [Employee]()
		let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
		let predicate = NSPredicate(format: "company.id == %@", companyID as CVarArg)
		fetchRequest.predicate = predicate
		
		do {
			employees = try self.context.fetch(fetchRequest)
		} catch let error as NSError {
			assertionFailure(error.description)
		}
		return employees
	}
	
	func fetchRequestEmployeeInfo(employeeID: UUID) -> [Employee]? {
		var employees = [Employee]()
		let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
		let predicate = NSPredicate(format: "id == %@", employeeID as CVarArg)
		fetchRequest.predicate = predicate
		
		do {
			employees = try self.context.fetch(fetchRequest)
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
			
			let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
			let predicate = NSPredicate(format: "id == %@", employeeID as CVarArg)
			fetchRequest.predicate = predicate
			
			do {
				let employees = try self.context.fetch(fetchRequest)
				
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
	
	func removeCompanyAt(id: UUID) {
		let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
		
		do {
			let companies = try self.context.fetch(fetchRequest)
			for company in companies {
				if company.id == id {
					self.context.delete(company)
				}
			}
		} catch let error as NSError {
			assertionFailure(error.description)
		}
		
		self.saveContext()
	}
	
	func removeEmployeeAt(id: UUID) {
		let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
		
		do {
			let employees = try self.context.fetch(fetchRequest)
			for employee in employees {
				if employee.id == id {
					self.context.delete(employee)
				}
			}
		} catch let error as NSError {
			assertionFailure(error.description)
		}
		
		self.saveContext()
	}
	
	func add(company name: String) {
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
			
			let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
		
			guard let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
			else { assertionFailure("Save error"); return }
			
			let predicate = NSPredicate(format: "id == %@", companyID as CVarArg)
			fetchRequest.predicate = predicate
			
			do {
				let company = try self.context.fetch(fetchRequest)
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
		if context.hasChanges {
			do {
				try self.context.save()
			} catch {
				assertionFailure(error.localizedDescription)
			}
		}
	}
}
