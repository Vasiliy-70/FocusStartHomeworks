//
//  SecondView.swift
//  Lessons3_UITabBar
//
//  Created by user183355 on 01.11.2020.
//

import UIKit

final class SecondView: UIView {
    
    // MARK: Properties
    
    enum Constants {
        static let titleText = "Title"
        static let descriptionText = """
                                This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!
                                """
        
        static let titleLabelFont: UIFont = .boldSystemFont(ofSize: 30)
        static let descriptionLabelFont: UIFont = .systemFont(ofSize: 17)
        static let titleLabelLines = 0
        static let descriptionLabelLines = 0
        
        static let titleLabelDistance: CGFloat = 10.0
        static let descriptionLabelDistance: CGFloat = 10.0
        static let borderSpace: CGFloat = 10.0
        
        static let imageHeight: CGFloat = 200.0
        static let imageWidth: CGFloat = 200.0
    }
    
    private var commonConstraints: [NSLayoutConstraint] = []
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    
    // MARK: ChangesCycle
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if (traitCollection != previousTraitCollection) {
            self.changeViewsLayout(traitCollection: traitCollection)
        }
    }
    
    // MARK: Views
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        self.setupViewsLayout()
        self.setupViewsAppearance()
        self.changeViewsLayout(traitCollection: traitCollection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Layout

private extension SecondView {
    
    func changeViewsLayout(traitCollection: UITraitCollection) {
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.compact, .regular):
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
        default:
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    func setupViewsLayout() {
        self.setupCommonConstraints()
        self.setupCompactLayout()
        self.setupRegularLayout()
    }
}

// MARK: Layout: Common

private extension SecondView {
    func setupCommonConstraints() {
        self.setupScrollViewCommonConstraints()
        self.setupImageViewCommonConstraints()
        self.setupLabelsCommonConstraints()
        
        NSLayoutConstraint.activate(self.commonConstraints)
    }
    
    func setupScrollViewCommonConstraints() {
        self.addSubview(scrollView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.commonConstraints.append(contentsOf: [
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupImageViewCommonConstraints() {
        self.scrollView.addSubview(imageView)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.commonConstraints.append(contentsOf: [
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor,
                                                constant: Constants.borderSpace),
            self.imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: Constants.borderSpace),
            self.imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }
    
    func setupLabelsCommonConstraints() {
        self.scrollView.addSubview(titleLabel)
        self.scrollView.addSubview(descriptionLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.commonConstraints.append(contentsOf: [
            self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -Constants.borderSpace),
        ])
        
        self.commonConstraints.append(contentsOf: [
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: Constants.borderSpace),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -Constants.borderSpace),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
    }
}

// MARK: Layout: Compact

private extension SecondView {
    func setupCompactLayout() {
        self.setupImageViewCompactConstraints()
        self.setupLabelsCompactConstraints()
    }
    
    func setupImageViewCompactConstraints() {
        self.compactConstraints.append(contentsOf: [
            self.imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -Constants.borderSpace)
        ])
    }
    
    func setupLabelsCompactConstraints() {
        self.compactConstraints.append(contentsOf: [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor,
                                                 constant: Constants.titleLabelDistance),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                     constant: Constants.borderSpace)
        ])
        
        self.compactConstraints.append(contentsOf: [
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                                constant: Constants.descriptionLabelDistance)
        ])
    }
}

// MARK: Layout: Regular

private extension SecondView {
    func setupRegularLayout() {
        self.setupImageViewRegularConstraints()
        self.setupLabelsRegularConstraints()
    }
    
    func setupImageViewRegularConstraints() {
        self.regularConstraints.append(contentsOf: [
            self.imageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth)
        ])
    }
    
    func setupLabelsRegularConstraints() {
        self.regularConstraints.append(contentsOf: [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.topAnchor),
            self.titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.imageView.bottomAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor,
                                                     constant: Constants.titleLabelDistance),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -Constants.borderSpace)
        ])
        
        self.regularConstraints.append(contentsOf: [
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                                constant: Constants.descriptionLabelDistance)
        ])
    }
}

// MARK: Appearance

private extension SecondView {
    func setupViewsAppearance() {
        self.setupImageView()
        self.setupLabelsView()
    }
    
    func setupImageView() {
        self.imageView.image = Images.dog.image
        self.contentMode = .scaleAspectFill
    }
    
    func setupLabelsView() {
        self.titleLabel.text = Constants.titleText
        self.titleLabel.font = Constants.titleLabelFont
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = Constants.titleLabelLines
        
        self.descriptionLabel.text = Constants.descriptionText
        self.descriptionLabel.font = Constants.descriptionLabelFont
        self.descriptionLabel.textAlignment = .justified
        self.descriptionLabel.numberOfLines = Constants.descriptionLabelLines
    }
}
