//
//  MainPresenter.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 01.12.2020.
//

import UIKit

protocol IMainPresenter: class {
	func downloadImageAt(url: String)
	func removeImageAt(index: Int)
	var images: [UIImage] { get }
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
	func removeImageAt(index: Int) {
		if self.imagesArray.indices.contains(index) {
			self.imagesArray.remove(at: index)
		}
		self.view?.updateTable()
	}
	
	var images: [UIImage] {
		return imagesArray
	}
	
	func downloadImageAt(url: String) {
		guard let url = URL(string: url) else {
			self.view?.show(error: "Input URL isn't correct")
			return
		}
		
		self.imagesArray.append(ImageState.waitingForImage ?? UIImage())
		self.view?.updateTable()
		
		self.queryService?.getDataAt(url: url, completion: { image, error in
			if let emptyImage = ImageState.waitingForImage,
			   let index = self.imagesArray.firstIndex(of: emptyImage) {
				if error != "" {
					self.imagesArray.remove(at: index)
					self.view?.show(error: error)
				} else {
					self.imagesArray[index] = UIImage(data:image) ?? UIImage()
				}
			}
			self.view?.updateTable()
		})
	}
	
}
