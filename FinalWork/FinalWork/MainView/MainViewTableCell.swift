//
//  MainViewTableCell.swift
//  FinalWork
//
//  Created by Боровик Василий on 17.12.2020.
//

import UIKit

protocol IMainViewTableCell {
	var newImage: UIImage { get set }
	var title: String? { get set }
	func updateContent()
}

final class MainViewTableCell: UITableViewCell {
	private var mainImage = UIImage()
	
	private var nameLabel: UILabel = {
		let nameLabel = UILabel()
		nameLabel.backgroundColor = .black
		nameLabel.textColor = .white
		nameLabel.textAlignment = .left
		nameLabel.alpha = 0.4
		return nameLabel
	}()
	
	private var mainImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleToFill
		return imageView
	}()
	
	private enum Constraints {
		static let imageViewOffset: CGFloat = 10
		static let cellHeight: CGFloat = 200
		static let nameLabelHeight: CGFloat = 40
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setupConstraints()
		self.setupLabelsConstraint()
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

extension MainViewTableCell {
	func setupConstraints() {
		self.setupImagesConstraints()
	}
	
	func setupImagesConstraints() {
		self.addSubview(self.mainImageView)
		self.mainImageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.mainImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.imageViewOffset),
			self.mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.mainImageView.heightAnchor.constraint(equalToConstant: Constraints.cellHeight - Constraints.imageViewOffset),
			self.mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraints.imageViewOffset)
		])
	}
	
	func setupLabelsConstraint() {
		self.mainImageView.addSubview(self.nameLabel)
		self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.nameLabel.bottomAnchor.constraint(equalTo: self.mainImageView.bottomAnchor),
			self.nameLabel.leadingAnchor.constraint(equalTo: self.mainImageView.leadingAnchor),
			self.nameLabel.trailingAnchor.constraint(equalTo: self.mainImageView.trailingAnchor),
			self.nameLabel.heightAnchor.constraint(equalToConstant: Constraints.nameLabelHeight)
		])
	}
}

// MARK: IMainViewTableCell

extension MainViewTableCell: IMainViewTableCell {
	var title: String? {
		get {
			self.nameLabel.text
		}
		set {
			self.nameLabel.text = newValue
		}
	}

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
}
