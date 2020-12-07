//
//  SecondPresenter.swift
//  Lessons8_DataBase
//
//  Created by Боровик Василий on 08.12.2020.
//

import UIKit

protocol ISecondPresenter {
	
}

final class SecondPresenter {
	weak var view: ISecondViewController?
	private let coordinateController: ICoordinateController
	private let model: TestModel
	
	public init(view: ISecondViewController, model: TestModel, coordinateController: ICoordinateController) {
		self.view = view
		self.coordinateController = coordinateController
		self.model = model
	}
}

extension SecondPresenter: ISecondPresenter {
	
}
