//
//  Builder.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 19.11.2020.
//

import UIKit

enum UIElements {
	case button
	case label
	case image
}

protocol IBuilder {
	func createViewController(elements: [UIElements], backgroundColor: UIColor)
	func retrieveViewController() -> UIViewController
}

// MARK: Builder settings

class Builder {
	private var view: BaseView
	private var UI: UIViewController
	private var viewConstraints = [NSLayoutConstraint]()
	
	enum Constraints {
		static let imageWidth: CGFloat = 300
		static let imageHeight: CGFloat = 400
		
		static let stackViewTopOffset: CGFloat = 10
		static let stackViewBottomOffset: CGFloat = -10
		static let stackViewLeadingOffset: CGFloat = 10
		static let stackViewTrailingOffset: CGFloat = -10
	}
	
	enum Constants {
		static let stackViewsCount = 3
		static let maxStackViewElements = 3
		static let mainStackViewSpacing: CGFloat = 10
		static let embeddedStackViewsSpacing: CGFloat = 10
		
		static let labelFont: UIFont = .systemFont(ofSize: 20)
	}
	
	init() {
		self.view = BaseView()
		self.UI = UIViewController()
	}
	
	func reset() {
		self.view = BaseView()
		self.viewConstraints.removeAll()
		self.UI = UIViewController()
	}
}

extension Builder: IBuilder {
	func retrieveViewController() -> UIViewController{
		let result = self.UI
		self.reset()
		return result
	}
	
	func createViewController(elements: [UIElements], backgroundColor: UIColor) {
		self.configureView(elements: elements, backgroundColor: backgroundColor)
		self.UI = FirstViewController(view: self.view)
	}
}

// MARK: UIElements building

extension Builder {
	func configureView(elements: [UIElements], backgroundColor: UIColor) {
		self.view.backgroundColor = backgroundColor
		
		let viewContent = configStacks(elements: elements)
		self.view.addSubview(viewContent)
		NSLayoutConstraint.activate(self.viewConstraints)
	}
	
	func configStacks(elements: [UIElements]) -> UIStackView {
		let mainStackView = self.configMainStackView()
		let embeddedStackViews = self.configEmbeddedStackViews(elements: elements)
		
		embeddedStackViews.forEach {
			mainStackView.addArrangedSubview($0)
		}

		return mainStackView
	}
	
	func configMainStackView() -> UIStackView {
		let stackView = configStackView(axis: .vertical, spacing: Constants.mainStackViewSpacing)
		
		self.viewConstraints.append(contentsOf: [
			stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constraints.stackViewTopOffset),
			stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: Constraints.stackViewBottomOffset),
			stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.stackViewLeadingOffset),
			stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: Constraints.stackViewTrailingOffset)
		])
		
		return stackView
	}
	
	func configEmbeddedStackViews(elements: [UIElements]) -> [UIStackView] {
		var stackViews = [UIStackView]()
		for _ in 0..<Constants.stackViewsCount {
			stackViews.append(configStackView(axis: .horizontal, spacing: Constants.embeddedStackViewsSpacing))
		}
		var elementsCount = 0
		var elementPosition = 0
		for element in elements {
			if elementPosition == Constants.stackViewsCount {
				break
			}
			switch element {
			case .button:
				stackViews[elementPosition].addArrangedSubview(self.configButton(type: .system, color: .blue, title: "PressMe!"))
			case .label:
				stackViews[elementPosition].addArrangedSubview(self.configLabel(font: Constants.labelFont, title: "ReadMe!"))
			case .image:
				stackViews[elementPosition].addArrangedSubview(self.configImageView(image: Images.dogImage ?? UIImage()))
			}

			elementsCount += 1
			if elementsCount == Constants.maxStackViewElements {
				elementPosition += 1
				elementsCount = 0
			}
			
		}
		return stackViews
	}
	
	func configStackView(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
		let stackView = UIStackView()
		
		stackView.axis = axis
		stackView.distribution = .fillEqually
		stackView.alignment = .center
		stackView.spacing = spacing
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}
	
	func configButton(type: UIButton.ButtonType, color: UIColor, title: String) -> UIButton {
		let button = UIButton(type: type)
		button.backgroundColor = color
		button.setTitle(title, for: .normal)
		
		return button
	}
	
	func configLabel(font: UIFont, title: String) -> UILabel {
		let label = UILabel()
		label.text = title
		label.font = font

		return label
	}
	
	func configImageView(image: UIImage) -> UIImageView{
		let imageView = UIImageView()
		imageView.image = image
		imageView.contentMode = .scaleAspectFit
		
		return imageView
	}
}
