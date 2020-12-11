//
//  EmployeeInfoViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

protocol IEmployeeInfoViewController {
	var editMode: EmployeeInfoMode { get }
	func showAlert()
	func updateData()
}

class EmployeeInfoViewController: UIViewController {

	private var alertView: UIAlertController?
	private var employee: [EmployeePropertyKey : String?] = [:]
	var presenter: IEmployeeInfoPresenter?
	private var viewMode: EmployeeInfoMode {
		didSet {
			self.editModeChange()
		}
	}
	
	init(editMode: EmployeeInfoMode) {
		self.viewMode = editMode
		super.init(nibName: nil, bundle: nil)
		
		self.configureAlerts()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.editModeChange()
		self.presenter?.viewDidLoad()
	}
	
	override func loadView() {
		self.view = EmployeeInfoView(viewController: self, editMode: self.viewMode)
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
		switch self.viewMode {
		case .editing:
			self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.actionSaveButton))]
			self.navigationItem.title = "Edit employee"
		case .addition:
			self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.actionSaveButton))]
			self.navigationItem.title = "Add employee"
		case .showing:
			self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editModeON))]
			self.navigationItem.title = "Info"
		}
		if var view = self.view as? IEmployeeInfoView {
			view.editMode = self.viewMode
		}
	}
	
	@objc func actionSaveButton() {
		if let view = self.view as? IEmployeeInfoView {
			self.employee = view.getEmployeeInfo()
			self.presenter?.actionSaveButton()
		}
	}
	@objc func editModeON() {
		self.viewMode = .editing
	}
	
}

// MARK: IEmployeeInfoViewController

extension EmployeeInfoViewController: IEmployeeInfoViewController {
	func updateData() {
		if let employee = self.presenter?.employee {
			self.employee = employee
			let view = self.view as? IEmployeeInfoView
			view?.setEmployee(info: self.employee)
		}
	}
	
	var editMode: EmployeeInfoMode {
		self.viewMode
	}
	
	var employeeInfo: [EmployeePropertyKey : String?] {
		self.employee
	}
	
	func showAlert() {
		if let alertView = self.alertView {
			self.present(alertView, animated: true, completion: nil)
		}
	}
}
