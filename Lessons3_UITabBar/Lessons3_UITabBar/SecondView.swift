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
        static let labelText = """
                                This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!
                                """
        
        
        static let titleDistance: CGFloat = 10.0
        static let textDistance: CGFloat = 10.0
        static let contentIndent: CGFloat = 10.0
        
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
            changeViewsLayout(traitCollection: traitCollection)
        }
    }
    
    // MARK: Views
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        setupViewsLayout()
        setupViewsAppearance()
        changeViewsLayout(traitCollection: traitCollection)
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
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: Constants.contentIndent),
            self.imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentIndent),
            self.imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }
    
    func setupLabelsCommonConstraints() {
        self.scrollView.addSubview(titleLabel)
        self.scrollView.addSubview(textLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.commonConstraints.append(contentsOf: [
            self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentIndent),
        ])
        
        self.commonConstraints.append(contentsOf: [
            self.textLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentIndent),
            self.textLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentIndent),
            self.textLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
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
            self.imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentIndent)
        ])
    }
    
    func setupLabelsCompactConstraints() {
        self.compactConstraints.append(contentsOf: [
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: Constants.titleDistance),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentIndent)
        ])
        
        self.compactConstraints.append(contentsOf: [
            self.textLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constants.textDistance)
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
            self.titleLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: Constants.titleDistance),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentIndent)
        ])
        
        self.regularConstraints.append(contentsOf: [
            self.textLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constants.textDistance)
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
        self.imageView.image = UIImage(named: "dog")
        self.contentMode = .scaleAspectFill
    }
    
    func setupLabelsView() {
        self.titleLabel.text = Constants.titleText
        self.titleLabel.font = .boldSystemFont(ofSize: 50)
        self.titleLabel.font = .systemFont(ofSize: 24)
        self.titleLabel.textAlignment = .center
        self.titleLabel.numberOfLines = 0
        
        self.textLabel.text = Constants.labelText
        self.textLabel.textAlignment = .justified
        self.textLabel.numberOfLines = 0
    }
}
