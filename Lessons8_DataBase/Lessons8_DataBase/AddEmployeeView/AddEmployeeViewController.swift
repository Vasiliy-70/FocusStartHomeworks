//
//  AddEmployeeViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

class AddEmployeeViewController: UIViewController {
	
	var employeeInfo: [EmployeePropertyKey : String?] = [:]
	var presenter: IAddEmployeePresenter?
	private var editMode: EmployeeInfoMode {
		didSet {
			self.editModeChange()
		}
	}
	
	init(editMode: EmployeeInfoMode) {
		self.editMode = editMode
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.editModeChange()
	}
	
	override func loadView() {
		if let presenter = self.presenter {
			self.employeeInfo = presenter.getEmployeeInfo()
		}
		self.view = AddEmployeeView(delegate: self, editMode: self.editMode)
	}
}

extension AddEmployeeViewController {
	func editModeChange() {
		switch self.editMode {
		case .editing:
			self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveEmployee))]
			
		case .showing:
			self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editModeON))]
		default:
			break
		}
		if var view = self.view as? IEmployeeInfoView {
			view.editMode = self.editMode
		}
	}
	
	@objc func saveEmployee() {
		if let view = self.view as? IEmployeeInfoView {
			let employee = view.getEmployeeInfo()
			self.presenter?.saveEmployee(info: employee, editMode: self.editMode)
		}
	}
	@objc func editModeON() {
		self.editMode = .editing
	}
	
}
