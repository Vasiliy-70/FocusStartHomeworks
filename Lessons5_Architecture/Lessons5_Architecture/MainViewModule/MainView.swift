//
//  MainView.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

final class MainView: UIView {
	// MARK: Settings
	weak var delegate: IMainViewUserAction?
	
	private enum Constraints {
		static let startButtonBottomOffset: CGFloat = 10
		static let startButtonHeight: CGFloat = 50
		static let startButtonWidth: CGFloat =  200
		
		static let descriptionLabelTopOffset: CGFloat = 10
		static let descriptionLabelHeight: CGFloat = 30
		static let descriptionLabelWidth: CGFloat = 200
		
		static let textFieldTopOffset: CGFloat = 40
		static let textFieldHeight: CGFloat = 30
		static let textFieldWidth: CGFloat = 200
	}
	
	private enum Constants {
		static let animateDuration: TimeInterval = 2
	}
	
	private let startButton = UIButton(type: .system)
	private let descriptionLabel = UILabel()
	private let valueInputField = UITextField()
	private var startButtonConstraints: [NSLayoutConstraint] = []
	
	init() {
		super.init(frame: .zero)
		
		self.setupAppearance()
		self.setupConstraints()
		self.setupNotifications()
		self.setupUserAction()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Appearance

private extension MainView {
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
		self.descriptionLabel.textAlignment = .center
		self.descriptionLabel.numberOfLines = 0
	}
	
	func setupTextFieldAppearance() {
		self.valueInputField.placeholder = "Введи число"
		self.valueInputField.textAlignment = .center
		self.valueInputField.keyboardType = .numberPad
	}
}

// MARK: Constraints

private extension MainView {
	func setupConstraints() {
		self.setupButtonConstraints()
		self.setupLabelConstraints()
		self.setupTextFieldConstraints()
	}
	
	func setupButtonConstraints() {
		self.addSubview(self.startButton)
		self.startButton.translatesAutoresizingMaskIntoConstraints = false
		
		self.startButtonConstraints.append(contentsOf: [
			self.startButton.heightAnchor.constraint(equalToConstant: Constraints.startButtonHeight),
			self.startButton.widthAnchor.constraint(equalToConstant: Constraints.startButtonWidth),
			self.startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.startButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.startButtonBottomOffset)
		])
		
		NSLayoutConstraint.activate(self.startButtonConstraints)
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
			self.valueInputField.topAnchor.constraint(greaterThanOrEqualTo: self.descriptionLabel.bottomAnchor, constant: Constraints.textFieldTopOffset),
			self.valueInputField.heightAnchor.constraint(equalToConstant: Constraints.textFieldHeight),
			self.valueInputField.widthAnchor.constraint(equalToConstant: Constraints.textFieldWidth),
			self.valueInputField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
}

// MARK: Notification

private extension MainView {
	func setupNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
}

// MARK: Action

private extension MainView {
	func setupUserAction() {
		self.setupStartButtonAction()
	}
	
	func setupStartButtonAction() {
		self.startButton.addTarget(self, action: #selector(self.startButtonTouchUp), for: .touchUpInside)
	}
	
	@objc func startButtonTouchUp(_ sender: UIButton) {
		self.delegate?.check(value: valueInputField.text ?? "")
		valueInputField.placeholder = "Ещё раз!"
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		guard let userInfo = notification.userInfo else { return }
		guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
		
		NSLayoutConstraint.deactivate(self.startButtonConstraints)
		
		UIView.animate(withDuration: Constants.animateDuration) {
			self.startButtonConstraints.removeLast()
			self.startButtonConstraints.append(
				self.startButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -(keyboardSize.height + Constraints.startButtonBottomOffset))
			)
			
			NSLayoutConstraint.activate(self.startButtonConstraints)
			self.layoutIfNeeded()
		}
	}
	
	@objc func keyboardWillHide(notification: NSNotification) {
		NSLayoutConstraint.deactivate(self.startButtonConstraints)
		
		UIView.animate(withDuration: Constants.animateDuration) {
			self.startButtonConstraints.removeLast()
			self.startButtonConstraints.append(
				self.startButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.startButtonBottomOffset)
			)
			
			NSLayoutConstraint.activate(self.startButtonConstraints)
			self.layoutIfNeeded()
		}
	}
}

// MARK: IMainView

extension MainView: IMainView {
	func show(value: String) {
		valueInputField.text = value
	}
	
	func show(tutorial: String) {
		self.descriptionLabel.text = tutorial
	}
}
