//
//  EventsViewController.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 22.11.2020.
//

import UIKit

protocol IEventsGeneration: class {
	func generateEvents()
}

final class EventsViewController: UIViewController {
	
	private let customView: EventsView
	private let eventsGenerator = EventsNotifier()

	init() {
		self.customView = EventsView(observable: eventsGenerator)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.view = self.customView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.customView.eventsGenerator = self
	}
}

extension EventsViewController: IEventsGeneration {
	func generateEvents() {
		let alphabet = "abcdefghijklmnopqrstuvwxyz"
		var id = ""
		for _ in 0...10 {
			let randomIndex = Int.random(in: 0..<alphabet.count)
			let charIndex = alphabet.index(alphabet.startIndex, offsetBy: randomIndex)
			id.append(alphabet[charIndex])
		}
		
		self.eventsGenerator.event = (id, .alarm)
		self.eventsGenerator.event = (id + "_2", .warning)
	}
}
