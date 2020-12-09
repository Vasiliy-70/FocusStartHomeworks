//
//  EmployeeView.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

class EmployeeView: UIView {
	
	private var delegate: AddEmployeeViewController
	
	private var nameLabel = UILabel()
	private var ageLabel = UILabel()
	private var experienceLabel = UILabel()
	private var educationLabel = UILabel()
	private var positionLabel = UILabel()
	
	private var nameField = UITextField()
	private var ageField = UITextField()
	private var experienceField = UITextField()
	private var educationField = UITextField()
	private var positionField = UITextField()
	
	private enum Constraints {
		static let labelsOffset: CGFloat = 10
		static let labelsWidth: CGFloat = 50
		
		static let textFieldsOffset: CGFloat = 10
	}
	
	init(delegate: AddEmployeeViewController) {
		self.delegate = delegate
		super.init(frame: .zero)
		self.backgroundColor = .white
		
		self.setupViewAppearance()
		self.setupViewConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


// MARK: View Appearance

extension EmployeeView {
	func setupViewAppearance() {
		self.setupLabelsView()
		self.setupTextFieldsView()
	}
	
	func setupLabelsView() {
		self.nameLabel.text = "Name:"
		self.ageLabel.text = "Возраст:"
		self.experienceLabel.text = "Стаж работы:"
		self.educationLabel.text = "Образование:"
		self.positionLabel.text = "Должность:"
	}
	
	func setupTextFieldsView() {
		self.nameField.borderStyle = .roundedRect
		self.ageField.borderStyle = .roundedRect
		self.experienceField.borderStyle = .roundedRect
		self.educationField.borderStyle = .roundedRect
		self.positionField.borderStyle = .roundedRect
		
		self.nameField.addTarget(self, action: #selector(self.fillEmployerName), for: .editingChanged)
	}
}


// MARK: Setup Constraints

extension EmployeeView {
	func setupViewConstraints() {
		self.setupLabelsConstraints()
		self.setupTextFieldsConstraints()
	}
	
	func setupLabelsConstraints() {
		self.addSubview(self.nameLabel)
		self.addSubview(self.ageLabel)
		self.addSubview(self.experienceLabel)
		self.addSubview(self.educationLabel)
		self.addSubview(self.positionLabel)
		
		self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
		self.ageLabel.translatesAutoresizingMaskIntoConstraints = false
		self.experienceLabel.translatesAutoresizingMaskIntoConstraints = false
		self.educationLabel.translatesAutoresizingMaskIntoConstraints = false
		self.positionLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.labelsOffset),
			self.nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.labelsOffset),
			self.nameLabel.widthAnchor.constraint(equalToConstant: Constraints.labelsWidth),
			
			self.ageLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: Constraints.labelsOffset),
			self.ageLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.labelsOffset),
			self.ageLabel.widthAnchor.constraint(equalToConstant: Constraints.labelsWidth),
			
			self.experienceLabel.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: Constraints.labelsOffset),
			self.experienceLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.labelsOffset),
			self.experienceLabel.widthAnchor.constraint(equalToConstant: Constraints.labelsWidth),
			
			self.educationLabel.topAnchor.constraint(equalTo: self.experienceLabel.bottomAnchor, constant: Constraints.labelsOffset),
			self.educationLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.labelsOffset),
			self.educationLabel.widthAnchor.constraint(equalToConstant: Constraints.labelsWidth),
			
			self.positionLabel.topAnchor.constraint(equalTo: self.educationLabel.bottomAnchor, constant: Constraints.labelsOffset),
			self.positionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.labelsOffset),
			self.positionLabel.widthAnchor.constraint(equalToConstant: Constraints.labelsWidth),
		])
	}
	
	func setupTextFieldsConstraints() {
		self.addSubview(self.nameField)
		self.addSubview(self.ageField)
		self.addSubview(self.experienceField)
		self.addSubview(self.educationField)
		self.addSubview(self.positionField)
		
		self.nameField.translatesAutoresizingMaskIntoConstraints = false
		self.ageField.translatesAutoresizingMaskIntoConstraints = false
		self.educationField.translatesAutoresizingMaskIntoConstraints = false
		self.experienceField.translatesAutoresizingMaskIntoConstraints = false
		self.positionField.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameField.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor),
			self.nameField.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: Constraints.textFieldsOffset),
			self.nameField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.textFieldsOffset),
			
			self.ageField.centerYAnchor.constraint(equalTo: self.ageLabel.centerYAnchor),
			self.ageField.leadingAnchor.constraint(equalTo: self.ageLabel.trailingAnchor, constant: Constraints.textFieldsOffset),
			self.ageField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.textFieldsOffset),
			
			self.experienceField.centerYAnchor.constraint(equalTo: self.experienceLabel.centerYAnchor),
			self.experienceField.leadingAnchor.constraint(equalTo: self.experienceLabel.trailingAnchor, constant: Constraints.textFieldsOffset),
			self.experienceField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.textFieldsOffset),
			
			self.educationField.centerYAnchor.constraint(equalTo: self.educationLabel.centerYAnchor),
			self.educationField.leadingAnchor.constraint(equalTo: self.educationLabel.trailingAnchor, constant: Constraints.textFieldsOffset),
			self.educationField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.textFieldsOffset),
			
			self.positionField.centerYAnchor.constraint(equalTo: self.positionLabel.centerYAnchor),
			self.positionField.leadingAnchor.constraint(equalTo: self.positionLabel.trailingAnchor, constant: Constraints.textFieldsOffset),
			self.positionField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.textFieldsOffset),
		])
	}
}

// MARK: UITextFieldDelegate

extension EmployeeView: UITextFieldDelegate {
	@objc func fillEmployerName() {
		//self.delegate.employeeInfo[.name] = nameField.text
	}
}
