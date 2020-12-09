//
//  SecondPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

protocol ISecondPresenter {
	func showAddEmployeeView()
}

final class SecondPresenter {
	weak var view: ISecondViewController?
	private let coordinateController: ICoordinateController
	private let queryModel = ModelQueryService.manager
	
	public init(view: ISecondViewController, coordinateController: ICoordinateController) {
		self.view = view
		self.coordinateController = coordinateController
		
	}
}

extension SecondPresenter: ISecondPresenter {
	func showAddEmployeeView() {
		self.coordinateController.showAddEmployeeList()
	}
}
