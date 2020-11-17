//
//  MainView.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

protocol IMainView: class {
	func show(data: String)
}

class MainView: UIView {
	// MARK: Settings
	weak var delegate: IMainViewUserAction?
	
	enum Constraints {
		static let startButtonBottomOffset: CGFloat = 50
		static let startButtonHeight: CGFloat = 50
		static let startButtonWidth: CGFloat =  200
		
		static let descriptionLabelTopOffset: CGFloat = 10
		static let descriptionLabelHeight: CGFloat = 30
		static let descriptionLabelWidth: CGFloat = 200
		
		static let textFieldTopOffset: CGFloat = 40
		static let textFieldHeight: CGFloat = 30
		static let textFieldWidth: CGFloat = 200
	}
	
	private let startButton = UIButton(type: .system)
	private let descriptionLabel = UILabel()
	private let valueInputField = UITextField()
	
	init() {
		super.init(frame: .zero)
		self.setupAppearance()
		self.setupConstraints()
		self.setupUserAction()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Appearance

extension MainView {
	func setupAppearance() {
		self.backgroundColor = .white
		self.setupButtonAppearance()
		self.setupLabelAppearance()
		self.setupTextFieldAppearance()
	}
	
	func setupButtonAppearance() {
		self.startButton.setTitle("Испытать удачу!", for: .normal)
		self.startButton.backgroundColor = .cyan
	}
	
	func setupLabelAppearance() {
		self.descriptionLabel.text = "Я загадываю число - ты отгадываешь!"
		self.descriptionLabel.textAlignment = .center
		self.descriptionLabel.numberOfLines = 0
	}
	
	func setupTextFieldAppearance() {
		self.valueInputField.placeholder = "Введи число"
		self.valueInputField.textAlignment = .center
	}
}

// MARK: Constraints

extension MainView {
	func setupConstraints() {
		self.setupButtonConstraints()
		self.setupLabelConstraints()
		self.setupTextFieldConstraints()
	}
	
	func setupButtonConstraints() {
		self.addSubview(self.startButton)
		self.startButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.startButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.startButtonBottomOffset),
			self.startButton.heightAnchor.constraint(equalToConstant: Constraints.startButtonHeight),
			self.startButton.widthAnchor.constraint(equalToConstant: Constraints.startButtonWidth),
			self.startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
	
	func setupLabelConstraints() {
		self.addSubview(self.descriptionLabel)
		self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.descriptionLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.descriptionLabelTopOffset),
			self.descriptionLabel.widthAnchor.constraint(equalToConstant: Constraints.descriptionLabelWidth),
			self.descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
	
	func setupTextFieldConstraints() {
		self.addSubview(self.valueInputField)
		self.valueInputField.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.valueInputField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: Constraints.textFieldTopOffset),
			self.valueInputField.heightAnchor.constraint(equalToConstant: Constraints.textFieldHeight),
			self.valueInputField.widthAnchor.constraint(equalToConstant: Constraints.textFieldWidth),
			self.valueInputField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
}

// MARK: Action

extension MainView {
	func setupUserAction() {
		self.setupStartButtonAction()
	}
	
	func setupStartButtonAction() {
		self.startButton.addTarget(self, action: #selector(startButtonTouchUp), for: .touchUpInside)
	}
	
	@objc func startButtonTouchUp(_ sender: UIButton) {
		print("buttonPush")
		self.delegate?.receiveUser(value: valueInputField.text ?? "")
		valueInputField.text = ""
		valueInputField.placeholder = "Ещё раз!"
	}
}

// MARK: IMainView

extension MainView: IMainView {

	func show(data: String) {
		self.descriptionLabel.text = data
	}
}
