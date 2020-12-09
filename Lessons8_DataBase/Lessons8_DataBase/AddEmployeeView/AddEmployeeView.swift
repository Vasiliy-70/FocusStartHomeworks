//
//  AddEmployeeView.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

protocol IEmployeeInfoView {
	func getEmployeeInfo() -> [EmployeePropertyKey : String?]
}

class AddEmployeeView: UIView {
	
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
	
	private var editMode: Bool = false {
		willSet {
			self.nameField.isUserInteractionEnabled = newValue
			self.ageField.isUserInteractionEnabled = newValue
			self.experienceField.isUserInteractionEnabled = newValue
			self.educationField.isUserInteractionEnabled = newValue
			self.positionField.isUserInteractionEnabled = newValue
			
			self.nameField.backgroundColor = newValue ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			self.ageField.backgroundColor = newValue ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			self.experienceField.backgroundColor = newValue ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			self.educationField.backgroundColor = newValue ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			self.positionField.backgroundColor = newValue ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			
			if !newValue {
				self.readEmployeeInfo()
			}
		}
	}
	
	private enum Constraints {
		static let labelsOffset: CGFloat = 20
		static let labelsWidth: CGFloat = 150
		
		static let textFieldsOffset: CGFloat = 10
	}
	
	private enum Constants {
		static var textFieldsBackground: UIColor = .white
	}
	
	init(delegate: AddEmployeeViewController, editMode: Bool) {
		self.delegate = delegate
		
		super.init(frame: .zero)
		
		self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		self.setupViewAppearance()
		self.setupViewConstraints()
		
		defer {
			self.editMode = editMode
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


// MARK: View Appearance

extension AddEmployeeView {
	func setupViewAppearance() {
		self.setupLabelsView()
		self.setupTextFieldsView()
	}
	
	func setupLabelsView() {
		self.nameLabel.text = "Имя:"
		self.ageLabel.text = "Возраст:"
		self.experienceLabel.text = "Стаж работы:"
		self.educationLabel.text = "Образование:"
		self.positionLabel.text = "Должность:"
		
		self.nameLabel.numberOfLines = 0
		self.ageLabel.numberOfLines = 0
		self.experienceLabel.numberOfLines = 0
		self.educationLabel.numberOfLines = 0
		self.positionLabel.numberOfLines = 0
	}
	
	func setupTextFieldsView() {
		self.nameField.borderStyle = .roundedRect
		self.ageField.borderStyle = .roundedRect
		self.experienceField.borderStyle = .roundedRect
		self.educationField.borderStyle = .roundedRect
		self.positionField.borderStyle = .roundedRect
	}
}


// MARK: Setup Constraints

extension AddEmployeeView {
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

extension AddEmployeeView: IEmployeeInfoView {
	func getEmployeeInfo() -> [EmployeePropertyKey : String?] {
		var info = [EmployeePropertyKey : String?]()
		info[.name] = self.nameField.text
		info[.age] = self.ageField.text
		info[.education] = self.educationField.text
		info[.experience] = self.experienceField.text
		info[.position] = self.positionField.text
		return info
	}
}

extension AddEmployeeView {
	func readEmployeeInfo() {
		let info = self.delegate.employeeInfo
		self.nameField.text = info[.name] ?? ""
		self.ageField.text = info[.age] ?? ""
		self.educationField.text = info[.education] ?? ""
		self.experienceField.text = info[.experience] ?? ""
		self.positionField.text = info[.position] ?? ""
	}
}
