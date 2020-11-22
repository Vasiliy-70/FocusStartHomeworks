//
//  EventsNotifier.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 22.11.2020.
//

import Foundation

protocol IEventsObservable: class {
	func register(observer: IEventsObserver)
	func unregister(observer: IEventsObserver)
	var event : (String, EventsType) { get set }
}

enum EventsType {
	case alarm
	case warning
	case info
}

final class EventsNotifier {
	private var observers = [IEventsObserver]()
	private var lastEvent : (String, EventsType)?
}

private extension EventsNotifier {
	func notify(events: String, type: EventsType) {
		let filterObservers = self.observers.filter {
			$0.eventsType == type
		}
		filterObservers.forEach {
			$0.received(Events: events, type: type)
		}
	}
}

extension EventsNotifier: IEventsObservable {
	func register(observer: IEventsObserver) {
		self.observers.append(observer)
	}
	
	func unregister(observer: IEventsObserver) {
		let newObservers = self.observers.filter {
			$0.id != observer.id
		}
		self.observers = newObservers
	}
	
	var event: (String, EventsType) {
		get {
			self.lastEvent ?? ("empty", .info)
		}
		set {
			self.lastEvent?.0 = newValue.0
			self.lastEvent?.1 = newValue.1
			self.notify(events: newValue.0, type: newValue.1)
		}
	}
}
