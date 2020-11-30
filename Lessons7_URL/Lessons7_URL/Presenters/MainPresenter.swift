//
//  MainPresenter.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 01.12.2020.
//

import UIKit

protocol IMainPresenter: class {
	func downloadImageAt(url: String)
	var image: [UIImage] { get }
}

final class MainPresenter {
	weak var view: IMainViewController?
	var queryService: IQueryService?
	private var imagesArray: [UIImage] = []
	
	
	public init(view: IMainViewController, queryService: IQueryService) {
		self.view = view
		self.queryService = queryService
	}
}

extension MainPresenter: IMainPresenter {
	var image: [UIImage] {
		return imagesArray
	}
	
	func downloadImageAt(url: String) {
		self.queryService?.getDataAt(url: url, completion: { image, error in
			if error != "" {
				self.view?.responseError(error: error)
			} else {
				self.imagesArray.append(UIImage(data: image) ?? UIImage())
				self.view?.updateImage()
			}
		})
	}
}
