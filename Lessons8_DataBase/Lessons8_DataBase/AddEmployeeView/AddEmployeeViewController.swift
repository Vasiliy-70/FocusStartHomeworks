//
//  AddEmployeeViewController.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

protocol IAddEmployeeView: class {
	//var employeeInfo: [(String, String)] { get set }
	var employeeInfo: [EmployeePropertyKey:String] { get set }
}

enum EmployeePropertyKey {
	case name
}

class AddEmployeeViewController: UIViewController, IAddEmployeeView {
	
	var employeeInfo: [EmployeePropertyKey : String] = [:]
	
	var presenter: IAddEmployeePresenter?
	//private var employeeInfo = [(String, String)]()
		
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveEmployee))]
    }
	
	override func loadView() {
		self.view = AddEmployeeView(delegate: self)
	}
}

extension AddEmployeeViewController {
	 @objc func saveEmployee() {
		guard let name = self.employeeInfo[.name] else { return }
			self.presenter?.saveEmployee(name: name)
	 }
 }
