//
//  TableCellView.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 30.11.2020.
//

import UIKit

protocol ITableCell {
	var newImage: UIImage { get set }
	var imageLoading: Bool { get set }
	func updateContent()
}

final class TableCellView: UITableViewCell {

	private var mainImage = UIImage()
	private var activity = false {
		willSet {
			if newValue {
				self.activityIndicator.startAnimating()
			} else {
				self.activityIndicator.stopAnimating()
			}
		}
	}
	
	private var mainImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private var activityIndicator: UIActivityIndicatorView = {
		let activityIndicator = UIActivityIndicatorView()
		activityIndicator.style = .medium
		return activityIndicator
	}()
	
	private enum Constraints {
		static let imageViewOffset: CGFloat = 10
		static let cellHeight: CGFloat = 300
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.mainImageView.image = newImage
	}
}

// MARK: SetupConstraints

extension TableCellView {
	func setupConstraints() {
		self.setupImagesConstraints()
		self.setupIndicatorsConstraints()
	}
	
	func setupImagesConstraints() {
		self.addSubview(self.mainImageView)
		self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.heightAnchor.constraint(equalToConstant: Constraints.cellHeight),
			self.mainImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.imageViewOffset),
			self.mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.mainImageView.heightAnchor.constraint(equalToConstant: Constraints.cellHeight - Constraints.imageViewOffset)
		])
	}
	
	func setupIndicatorsConstraints() {
		self.addSubview(self.activityIndicator)
		self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.activityIndicator.centerYAnchor.constraint(equalTo: self.mainImageView.centerYAnchor),
			self.activityIndicator.centerXAnchor.constraint(equalTo: self.mainImageView.centerXAnchor)
		])
	}
}

// MARK: ITableCell

extension TableCellView: ITableCell {
	func updateContent() {
		self.layoutSubviews()
	}
	
	var newImage: UIImage {
		get {
			self.mainImage
		}
		set {
			self.mainImage = newValue
		}
	}
	
	var imageLoading: Bool {
		get {
			self.activity
		}
		set {
			self.activity = newValue
		}
	}
}
