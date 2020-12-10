//
//  EmployeeInfoViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

protocol IEmployeeInfoViewController {
	func showAlert()
}

class EmployeeInfoViewController: UIViewController {

	private var alertView: UIAlertController?
	var employeeInfo: [EmployeePropertyKey : String?] = [:]
	var presenter: IEmployeeInfoPresenter?
	private var editMode: EmployeeInfoMode {
		didSet {
			self.editModeChange()
		}
	}
	
	init(editMode: EmployeeInfoMode) {
		self.editMode = editMode
		super.init(nibName: nil, bundle: nil)
		self.configureAlerts()
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
		self.view = EmployeeInfoView(delegate: self, editMode: self.editMode)
	}
}

// MARK: ConfigureController

extension EmployeeInfoViewController {
	func configureAlerts() {
		let alertView = UIAlertController(title: "Error", message: "Invalid data entered", preferredStyle: .alert)
		let action = UIAlertAction(title: "Apply", style: .default, handler: nil)
		alertView.addAction(action)
		self.alertView = alertView
	}
}

// MARK: Action

extension EmployeeInfoViewController {
	func editModeChange() {
		switch self.editMode {
		case .editing:
			self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveEmployee))]
			self.navigationItem.title = "Edit employee"
		case .addition:
			self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveEmployee))]
			self.navigationItem.title = "Add employee"
		case .showing:
			self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editModeON))]
			self.navigationItem.title = "Info"
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

// MARK: IEmployeeInfoViewController

extension EmployeeInfoViewController: IEmployeeInfoViewController {
	func showAlert() {
		if let alertView = self.alertView {
			self.present(alertView, animated: true, completion: nil)
		}
	}
}
