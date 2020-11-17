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
	weak var delegate: IMainViewDelegate?
	
	enum Constraints {
		static let startButtonBottomOffset: CGFloat = 150
		static let startButtonHeight: CGFloat = 50
		static let startButtonWidth: CGFloat =  50
		
		static let descriptionLabelTopOffset: CGFloat = 10
		static let descriptionLabelHeight: CGFloat = 30
		static let descriptionLabelWidth: CGFloat = 200
		
		static let textFieldTopOffset: CGFloat = 40
		static let textFieldHeight: CGFloat = 30
		static let textFieldWidth: CGFloat = 200
	}
	
	private let startButton = UIButton()
	private let descriptionLabel = UILabel()
	private let textField = UITextField()
	
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
		self.startButton.setTitle("Start!", for: .normal)
		self.startButton.backgroundColor = .blue
	}
	
	func setupLabelAppearance() {
		self.descriptionLabel.text = "Я загадываю число - ты отгадываешь!"
		self.descriptionLabel.textAlignment = .center
		self.descriptionLabel.numberOfLines = 0
	}
	
	func setupTextFieldAppearance() {
		self.textField.text = "Введите число"
		self.textField.textAlignment = .center
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
			self.startButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.startButtonBottomOffset),
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
		self.addSubview(self.textField)
		self.textField.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.textField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: Constraints.textFieldTopOffset),
			self.textField.heightAnchor.constraint(equalToConstant: Constraints.textFieldHeight),
			self.textField.widthAnchor.constraint(equalToConstant: Constraints.textFieldWidth),
			self.textField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
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
		self.delegate?.buttonPushed()
	}
}

// MARK: IMainView

extension MainView: IMainView {

	func show(data: String) {
		self.descriptionLabel.text = "Угадай число, которое я загадал (диапазон:" + data
	}
}
