//
//  EventsUILabel.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 22.11.2020.
//

import UIKit

protocol IEventsObserver: class {
	var id: String { get }
	var eventsType: EventsType { get }
	func received(Events: String, type: EventsType)
}

final class EventsUILabel: UILabel {
	private let idString = UUID().uuidString
	private let type: EventsType
	
	init(eventsType: EventsType) {
		self.type = eventsType
		super.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension EventsUILabel: IEventsObserver {
	var id: String {
		get { self.idString }
	}
	
	var eventsType: EventsType {
		get { self.type }
	}
	
	func received(Events: String, type: EventsType) {
		if (type == self.type) {
			self.text = Events
		}
	}
}
