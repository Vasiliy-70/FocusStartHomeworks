//
//  StatsView.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 16.11.2020.
//

import UIKit

class StatsView: UIView {
	weak var delegate: IMainViewUserAction?
	
	private enum Constraints {
		static let descriptionLabelTopOffset: CGFloat = 10
		static let descriptionLabelHeight: CGFloat = 30
		static let descriptionLabelWidth: CGFloat = 200
	}
	
	private let descriptionLabel = UILabel()
	
	init() {
		super.init(frame: .zero)
		self.setupAppearance()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Appearance

extension StatsView {
	func setupAppearance() {
		self.backgroundColor = .green
		self.setupLabelAppearance()
	}
	
	func setupLabelAppearance() {
		self.descriptionLabel.textAlignment = .center
		self.descriptionLabel.numberOfLines = 0
	}
}

// MARK: Constraints

extension StatsView {
	func setupConstraints() {
		self.addSubview(self.descriptionLabel)
		self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			self.descriptionLabel.widthAnchor.constraint(equalToConstant: Constraints.descriptionLabelWidth),
			self.descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}
}

// MARK: IStatsView

extension StatsView: IStatsView {
	func show(string: String) {
		self.descriptionLabel.text = string
	}
}

