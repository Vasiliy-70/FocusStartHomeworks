//
//  TableCellView.swift
//  Lessons7_URL
//
//  Created by Боровик Василий on 30.11.2020.
//

import UIKit

final class TableCellView: UITableViewCell {

	var mainImage: UIImage?
	
	private var mainImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private enum Constraints {
		static let mainImageViewWidth: CGFloat = 50
		static let mainImageViewHeight: CGFloat = 100
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.addSubview(self.mainImageView)
		
		NSLayoutConstraint.activate([
			self.mainImageView.topAnchor.constraint(equalTo: self.topAnchor),
			self.mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			self.mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if let image = mainImage {
			self.mainImageView.image = image
		}
	}
}
