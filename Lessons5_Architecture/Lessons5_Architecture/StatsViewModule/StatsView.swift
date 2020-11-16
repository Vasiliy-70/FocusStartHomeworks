//
//  StatsView.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

protocol IStatsView: class {
	func show(data: String)
}

class StatsView: UIView {
	
	// MARK: Settings
	weak var delegate: IMainViewDelegate?
	
	enum Constraints {
		static let startButtonBottomOffset: CGFloat = 150
		static let startButtonHeight: CGFloat = 50
		static let startButtonWidth: CGFloat =  50
		
		static let descriptionLabelTopOffset: CGFloat = 10
		static let descriptionLabelHeight: CGFloat = 30
		static let descriptionLabelWidth: CGFloat = 200
		
	}
	
	private let startButton = UIButton()
	private let descriptionLabel = UILabel()
	
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

extension StatsView {
	func setupAppearance() {
		self.backgroundColor = .white
		self.setupButtonAppearance()
		self.setupLabelAppearance()
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
	
}

// MARK: Constraints

extension StatsView {
	func setupConstraints() {
		self.setupButtonConstraints()
		self.setupLabelConstraints()
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
}

// MARK: Action

extension StatsView {
	func setupUserAction() {
		self.setupStartButtonAction()
	}
	
	func setupStartButtonAction() {
		self.startButton.addTarget(self, action: #selector(startButtonTouchUp), for: .touchUpInside)
	}
	
	@objc func startButtonTouchUp(_ sender: UIButton) {
		print("buttonPush")
		self.delegate?.requestData()
	}
}

// MARK: IMainView

extension StatsView: IStatsView {

	func show(data: String) {
		self.descriptionLabel.text = "Угадай число, которое я загадал (диапазон:" + data
	}
}

