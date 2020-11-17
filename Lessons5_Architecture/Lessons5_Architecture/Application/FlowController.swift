//
//  FlowController.swift
//  Lessons5_Architecture
//
//  Created by Боровик Василий on 17.11.2020.
//
import UIKit

final class FlowController
{
	private let coordinationController: CoordinateController
	let firstVC: UIViewController
	
	init(coordinationController: CoordinateController) {
		self.coordinationController = coordinationController
		self.firstVC = ModuleAssembly.createMainModule(coordinateController: self.coordinationController)
		self.coordinationController.addModule(number: .first, vc: firstVC )
		self.coordinationController.addModule(number: .second,
											  vc: ModuleAssembly.createStatsModule(coordinateController: self.coordinationController))
	}
}
