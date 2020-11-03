//
//  FirstView.swift
//  Homework-3_UITabBar
//
//  Created by user183355 on 31.10.2020.
//

import UIKit

final class FirstView: UIView {

// MARK: Properties
    
    private let label1 = UILabel()
    private let label2 = UILabel()
    private let label3 = UILabel()
    
    private let roundButton = UIButton()
    private let rectangleButton = UIButton()
    
    private let imageView = UIImageView()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    enum Constants {
        static let textLabel1 = "text1"
        static let textLabel2 = "text2"
        static let textLabel3 = """
                                text3
                                text3
                                text3
                                """
        
        static let textLabel1Distance: CGFloat = 8.0
        static let textLabel2Distance: CGFloat = 10.0
        static let textLabel3Distance: CGFloat = 12.0
        
        static let roundButtonDistance: CGFloat = 14.0
        static let rectangleButtonDistance: CGFloat = 16.0
        static let imageViewDistance: CGFloat = 8.0
        
        static let roundButtonWidth: CGFloat = 50
        static let roundButtonHeight: CGFloat = 50
        
        static let rectangleButtonWidth: CGFloat = 150
        static let rectangleButtonHeight: CGFloat = 50
    }
    
// MARK: Views
    
    public init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemGreen
        
        self.setupViewsLayout()
        self.setupViewsAppearances()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       self.roundButton.layer.cornerRadius = self.roundButton.frame.height / 2
    }
}

// MARK: Appearance

private extension FirstView {
    func setupViewsAppearances() {
        self.setupLabelView()
        self.setupButtonView()
        self.setupImageView()
        self.setupActivityIndicatorView()
    }
    
    func setupLabelView() {
        self.label1.text = Constants.textLabel1
        
        self.label2.text = Constants.textLabel2
        self.label2.font = .boldSystemFont(ofSize: 18)
        
        self.label3.text = Constants.textLabel3
        self.label3.font = .italicSystemFont(ofSize: 24)
        self.label3.numberOfLines = 2
    }
    
    func setupButtonView() {
        self.roundButton.backgroundColor = .purple
        self.roundButton.layer.borderWidth = 1
        
        self.rectangleButton.backgroundColor = .blue
        self.rectangleButton.layer.borderWidth = 1
        self.rectangleButton.layer.cornerRadius = 8

        self.layoutIfNeeded()
    }
    
    func setupImageView() {
        self.imageView.image = Images.dog.image
        self.imageView.contentMode = .scaleAspectFill
    }
    
    func setupActivityIndicatorView() {
        self.activityIndicator.startAnimating()
    }
}

// MARK: Layout

private extension FirstView {
    func setupViewsLayout() {
        self.setupLabelConstraints()
        self.setupButtonConstraints()
        self.setupImageConstraints()
        self.setupActivityIndicatorConstraints()
    }
    
    func setupLabelConstraints() {
        self.addSubview(label1)
        self.addSubview(label2)
        self.addSubview(label3)
        
        self.label1.translatesAutoresizingMaskIntoConstraints = false
        self.label2.translatesAutoresizingMaskIntoConstraints = false
        self.label3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label1.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                             constant: Constants.textLabel1Distance),
            self.label1.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            self.label2.topAnchor.constraint(greaterThanOrEqualTo: self.label1.bottomAnchor,
                                             constant: Constants.textLabel2Distance),
            self.label2.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            self.label3.topAnchor.constraint(greaterThanOrEqualTo: self.label2.bottomAnchor,
                                             constant: Constants.textLabel3Distance),
            self.label3.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func setupButtonConstraints() {
        self.addSubview(roundButton)
        self.addSubview(rectangleButton)
        
        self.roundButton.translatesAutoresizingMaskIntoConstraints = false
        self.rectangleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.roundButton.topAnchor.constraint(greaterThanOrEqualTo: self.label3.bottomAnchor,
                                                  constant: Constants.roundButtonDistance),
            self.roundButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.roundButton.widthAnchor.constraint(equalToConstant: Constants.roundButtonWidth),
            self.roundButton.heightAnchor.constraint(equalToConstant: Constants.roundButtonHeight),
            
            self.rectangleButton.topAnchor.constraint(greaterThanOrEqualTo: self.roundButton.bottomAnchor,
                                                      constant: Constants.rectangleButtonDistance),
            self.rectangleButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.rectangleButton.widthAnchor.constraint(equalToConstant: Constants.rectangleButtonWidth),
            self.rectangleButton.heightAnchor.constraint(equalToConstant: Constants.rectangleButtonHeight)
        ])
    }
    
    func setupImageConstraints() {
        self.addSubview(imageView)
    
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.imageViewDistance),
            self.imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: 150),
            self.imageView.widthAnchor.constraint(equalToConstant: 150)
        
        ])
    }
    
    func setupActivityIndicatorConstraints() {
        self.addSubview(activityIndicator)
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor)
        ])
    }
}
