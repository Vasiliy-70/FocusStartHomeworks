//
//  EventsView.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 22.11.2020.
//

import UIKit

final class EventsView: UIView {
	private let alarmLabel = EventsUILabel(eventsType: .alarm)
	private let warningLabel = EventsUILabel(eventsType: .warning)
	private let generationButton = UIButton(type: .system)
	private let alarmRegisteredSwitch = UISwitch()
	private let alarmRegisteredSwitchLabel = UILabel()
	private let warningRegisteredSwitch = UISwitch()
	private let warningRegisteredSwitchLabel = UILabel()
	private let subscriptionSettings = UIStackView()
	private var subscriptionStacks = [UIStackView]()
	
	weak var eventsGenerator: IEventsGeneration?
	weak var observable: IEventsObservable?
	private let idString: String?
	
	enum Constraints {
		static let alarmLabelOffset: CGFloat  = 20
		static let alarmLabelHeight: CGFloat = 30
		
		static let warningLabelOffset: CGFloat = 20
		static let warningLabelHeight: CGFloat = 30
		
		static let generationButtonOffset: CGFloat = 30
		static let generationButtonHeight: CGFloat = 50
		static let generationButtonWidth: CGFloat = 150
		
		static let alarmRegisteredSwitchOffset: CGFloat = 10
		static let alarmRegisteredSwitchWidth: CGFloat = 50
		static let alarmRegisteredSwitchHeight: CGFloat = 20
		
		static let subscriptionSettingsOffset: CGFloat = 10
		static let subscriptionSettingsHeight: CGFloat = 100
	}
	
	enum Constants {
		static let subscriptionSettingsSpacing: CGFloat = 30
	}
	
	public init(observable: IEventsObservable) {
		self.observable = observable
		self.idString = UUID().uuidString
		
		super.init(frame: .zero)
		self.setupViewAppearance()
		self.setupViewLayouts()
		self.setupEvents()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

// MARK: Appearance

private extension EventsView {
	func setupViewAppearance() {
		self.setupButtonsView()
		self.setupLabelsView()
		self.setupStacksView()
		self.setupSwitchesView()
		self.backgroundColor = .systemGray
	}
	
	func setupButtonsView() {
		self.generationButton.setTitle("Generation Events", for: .normal)
		self.generationButton.backgroundColor = .blue
	}
	
	func setupLabelsView() {
		self.alarmLabel.text = "Аварийные сообщения"
		self.alarmLabel.textAlignment = .center
		self.alarmLabel.backgroundColor = .red
		
		self.warningLabel.text = "Предупредительные сообщения"
		self.warningLabel.textAlignment = .center
		self.warningLabel.backgroundColor = .yellow
		
		self.alarmRegisteredSwitchLabel.text = "Подписка на alarms"
		self.alarmRegisteredSwitchLabel.textAlignment = .left
		
		self.warningRegisteredSwitchLabel.text = "Подписка на warnings"
		self.warningRegisteredSwitchLabel.textAlignment = .left
	}
	
	func setupStacksView() {
		self.subscriptionSettings.axis = .horizontal
		self.subscriptionSettings.alignment = .center
		self.subscriptionSettings.distribution = .fillProportionally
		self.subscriptionSettings.spacing = Constants.subscriptionSettingsSpacing
		
		self.subscriptionStacks.append(self.setupSubscriptionStack())
		self.subscriptionStacks[0].addArrangedSubview(self.alarmRegisteredSwitchLabel)
		self.subscriptionStacks[0].addArrangedSubview(self.warningRegisteredSwitchLabel)
		
		self.subscriptionStacks.append(self.setupSubscriptionStack())
		self.subscriptionStacks[1].addArrangedSubview(self.alarmRegisteredSwitch)
		self.subscriptionStacks[1].addArrangedSubview(self.warningRegisteredSwitch)
		
		self.subscriptionStacks.forEach {
			self.subscriptionSettings.addArrangedSubview($0)
		}
	}
	
	func setupSwitchesView() {
		self.alarmRegisteredSwitch.isOn = true
		self.warningRegisteredSwitch.isOn = true
	}
	
	func setupSubscriptionStack() -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .leading
		stackView.distribution = .fillProportionally
		stackView.spacing = Constants.subscriptionSettingsSpacing
		
		return stackView
	}
}

// MARK: Layout

private extension EventsView {
	func setupViewLayouts() {
		self.setupLabelsConstraints()
		self.setupButtonsConstraints()
		self.setupStacksConstraints()
	}
	
	func setupButtonsConstraints() {
		self.addSubview(self.generationButton)
		self.generationButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.generationButton.topAnchor.constraint(equalTo: self.warningLabel.bottomAnchor, constant: Constraints.generationButtonOffset),
			self.generationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			self.generationButton.heightAnchor.constraint(equalToConstant: Constraints.generationButtonHeight),
			self.generationButton.widthAnchor.constraint(equalToConstant: Constraints.generationButtonWidth)
		])
	}
	
	func setupLabelsConstraints() {
		self.addSubview(self.alarmLabel)
		self.alarmLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.alarmLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.alarmLabelOffset),
			self.alarmLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.alarmLabelOffset),
			self.alarmLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.alarmLabelOffset),
			self.alarmLabel.heightAnchor.constraint(equalToConstant: Constraints.alarmLabelHeight)
		])
		
		self.addSubview(self.warningLabel)
		self.warningLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.warningLabel.topAnchor.constraint(equalTo: self.alarmLabel.bottomAnchor, constant: Constraints.warningLabelOffset),
			self.warningLabel.leadingAnchor.constraint(equalTo: self.alarmLabel.leadingAnchor),
			self.warningLabel.trailingAnchor.constraint(equalTo: self.alarmLabel.trailingAnchor),
			self.warningLabel.heightAnchor.constraint(equalToConstant: Constraints.warningLabelHeight)
		])
	}
	
	func setupStacksConstraints() {
		self.addSubview(self.subscriptionSettings)
		self.subscriptionSettings.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.subscriptionSettings.topAnchor.constraint(equalTo: self.generationButton.bottomAnchor, constant: Constraints.subscriptionSettingsOffset),
			self.subscriptionSettings.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.subscriptionSettingsOffset),
			self.subscriptionSettings.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.subscriptionSettingsOffset),
			self.subscriptionSettings.heightAnchor.constraint(equalToConstant: Constraints.subscriptionSettingsHeight)
		])
	}
}

// MARK: Events

private extension EventsView {
	func setupEvents() {
		self.observable?.register(observer: self.alarmLabel)
		self.observable?.register(observer: self.warningLabel)
		self.setupButtonsAction()
		self.setupSwitchesAction()
	}
	
	func setupButtonsAction() {
		self.generationButton.addTarget(self, action: #selector(generationButtonTouchUp), for: .touchUpInside)
	}
	
	@objc func generationButtonTouchUp(_ sender: UIButton) {
		self.eventsGenerator?.generateEvents()
	}
	
	func setupSwitchesAction() {
		self.alarmRegisteredSwitch.addTarget(self, action: #selector(alarmSubscriptionChange), for: .valueChanged)
		
		self.warningRegisteredSwitch.addTarget(self, action: #selector(warningSubscriptionChange), for: .valueChanged)
	}
	
	@objc func alarmSubscriptionChange(_ sender: UISwitch) {
		if (!sender.isOn) {
			self.observable?.unregister(observer: self.alarmLabel)
		} else {
			self.observable?.register(observer: self.alarmLabel)
		}
	}
	
	@objc func warningSubscriptionChange(_ sender: UISwitch) {
		if (!sender.isOn) {
			self.observable?.unregister(observer: self.warningLabel)
		} else {
			self.observable?.register(observer: self.warningLabel)
		}
	}
}

