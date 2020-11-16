//
//  FirstView.swift
//  Homework-3_UITabBar
//
//  Created by user183355 on 31.10.2020.
//

import UIKit

final class FirstView: UIView {

    // MARK: Properties
    
    private let standardTextLabel = UILabel()
    private let boldTextLabel = UILabel()
    private let multilineTextLabel = UILabel()
    
    private let roundButton = UIButton()
    private let rectangleButton = UIButton()
    
    private let imageView = UIImageView()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    enum Constants {
        static let standardText = "text1"
        static let boldText = "text2"
        static let multilineText = """
                                text3
                                text3
                                text3
                                """
        
        static let standardTextFont: UIFont = .systemFont(ofSize: 17)
        static let boldTextFont: UIFont = .boldSystemFont(ofSize: 18)
        static let multilineTextFont: UIFont = .italicSystemFont(ofSize: 24)
        static let multilineTextLines = 2
        
        static let roundButtonWidth: CGFloat = 50
        static let roundButtonHeight: CGFloat = 50
        static let roundButtonBorderWidth: CGFloat = 1
        
        static let rectangleButtonWidth: CGFloat = 150
        static let rectangleButtonHeight: CGFloat = 50
        static let rectangleButtonBorderWidth: CGFloat = 1
        static let rectangleButtonCornerRadius: CGFloat = 8
        
        static let imageViewHeight: CGFloat = 150
        static let imageViewWidth: CGFloat = 150
        
        static let standardTextLabelDistance: CGFloat = 8.0
        static let boldTextLabelDistance: CGFloat = 10.0
        static let multilineTextLabelDistance: CGFloat = 12.0
        
        static let roundButtonDistance: CGFloat = 14.0
        static let rectangleButtonDistance: CGFloat = 16.0
        static let imageViewDistance: CGFloat = 8.0
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
        self.standardTextLabel.text = Constants.standardText
        self.standardTextLabel.font = Constants.standardTextFont
        
        self.boldTextLabel.text = Constants.boldText
        self.boldTextLabel.font = Constants.boldTextFont
        
        self.multilineTextLabel.text = Constants.multilineText
        self.multilineTextLabel.font = Constants.multilineTextFont
        self.multilineTextLabel.numberOfLines = Constants.multilineTextLines
    }
    
    func setupButtonView() {
        self.roundButton.backgroundColor = .purple
        self.roundButton.layer.borderWidth = Constants.roundButtonBorderWidth
        
        self.rectangleButton.backgroundColor = .blue
        self.rectangleButton.layer.borderWidth = Constants.rectangleButtonBorderWidth
        self.rectangleButton.layer.cornerRadius = Constants.rectangleButtonCornerRadius

        self.layoutIfNeeded()
    }
    
    func setupImageView() {
		self.imageView.image = Images.dogImage
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
        self.addSubview(standardTextLabel)
        self.addSubview(boldTextLabel)
        self.addSubview(multilineTextLabel)
        
        self.standardTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.boldTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.multilineTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.standardTextLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                             constant: Constants.standardTextLabelDistance),
            self.standardTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.boldTextLabel.topAnchor.constraint(greaterThanOrEqualTo: self.standardTextLabel.bottomAnchor,
                                             constant: Constants.boldTextLabelDistance),
            self.boldTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.multilineTextLabel.topAnchor.constraint(greaterThanOrEqualTo: self.boldTextLabel.bottomAnchor,
                                             constant: Constants.multilineTextLabelDistance),
            self.multilineTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupButtonConstraints() {
        self.addSubview(roundButton)
        self.addSubview(rectangleButton)
        
        self.roundButton.translatesAutoresizingMaskIntoConstraints = false
        self.rectangleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.roundButton.topAnchor.constraint(greaterThanOrEqualTo: self.multilineTextLabel.bottomAnchor,
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
            self.imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight),
            self.imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidth)
        
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
