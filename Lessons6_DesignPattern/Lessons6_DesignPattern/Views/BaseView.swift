//
//  BaseView.swift
//  Lessons6_DesignPattern
//
//  Created by Боровик Василий on 21.11.2020.
//

import UIKit

class BaseView: UIView {
	public init() {
		super.init(frame: .zero)
		self.backgroundColor = .systemGreen
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

