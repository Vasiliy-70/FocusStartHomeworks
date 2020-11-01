//
//  FirstView.swift
//  Homework-3_UITabBar
//
//  Created by user183355 on 31.10.2020.
//

import UIKit

class FirstView: UIView {

// MARK: Views
    
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let label3 = UILabel()
    
    enum Constants {
        static let textLabel1 = "text1"
        static let textLabel2 = "text2"
        static let textLabel3 = """
                                text3
                                text3
                                """
    }
    
    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemRed
        
        self.setupViewsAppearances()
        self.setupViewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: Appearance

private extension FirstView {
    func setupViewsAppearances() {
        self.setupLabelViewAppearances()
    }
    
    func setupLabelViewAppearances() {
        self.label1.text = Constants.textLabel1
        
        self.label2.text = Constants.textLabel2
        self.label2.font = .boldSystemFont(ofSize: 18)
        self.label2.numberOfLines = 2
        
        self.label3.text = Constants.textLabel3
        self.label3.font = .italicSystemFont(ofSize: 24)
        self.label3.numberOfLines = 2
    }
}

// MARK: Layout

private extension FirstView {
    func setupViewsLayout() {
        self.setupLabelViewLayout()
    }
    
    func setupLabelViewLayout() {
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)
        
        self.label1.translatesAutoresizingMaskIntoConstraints = false
        self.label2.translatesAutoresizingMaskIntoConstraints = false
        self.label3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label1.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.label1.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            self.label2.topAnchor.constraint(greaterThanOrEqualTo: self.label1.bottomAnchor, constant: 16),
            self.label2.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            self.label3.topAnchor.constraint(greaterThanOrEqualTo: self.label2.bottomAnchor, constant: 16),
            self.label3.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
