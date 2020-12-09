//
//  AddEmployeeView.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 09.12.2020.
//

import UIKit

class AddEmployeeView: UIView {
	
	private var delegate: IAddEmployeeView
	
	private var nameLabel = UILabel()
	private var nameField = UITextField()

	private enum Constraints {
		static let nameLabelOffset: CGFloat = 10
		static let nameLabelWidth: CGFloat = 50
		static let nameFieldOffset: CGFloat = 10
	}
	
	init(delegate: IAddEmployeeView) {
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

extension AddEmployeeView {
	func setupViewAppearance() {
		self.setupLabelsView()
		self.setupTextFieldsView()
	}
	
	func setupLabelsView() {
		self.nameLabel.text = "Name:"
	}
	
	func setupTextFieldsView() {
		self.nameField.borderStyle = .roundedRect
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
		self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.nameLabelOffset),
			self.nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.nameLabelOffset),
			self.nameLabel.widthAnchor.constraint(equalToConstant: Constraints.nameLabelWidth)
		])
	}
	
	func setupTextFieldsConstraints() {
		self.addSubview(self.nameField)
		self.nameField.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameField.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor),
			self.nameField.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: Constraints.nameFieldOffset),
			self.nameField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.nameFieldOffset)
		])
	}
}

// MARK: UITextFieldDelegate

extension AddEmployeeView: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		switch textField {
		case self.nameField:
			self.delegate.employeeInfo[.name] = textField.text ?? ""
		default:
			break
		}
	}
}
