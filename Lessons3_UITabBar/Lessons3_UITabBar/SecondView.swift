//
//  SecondView.swift
//  Lessons3_UITabBar
//
//  Created by user183355 on 01.11.2020.
//

import UIKit

final class SecondView: UIView {
    
// MARK: Views
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    
    enum Constants {
        static let titleText = "Title"
        static let labelText = """
                                This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!This text is so big!
                                """
        
        
        static let titleDistance: CGFloat = 10.0
        static let textDistance: CGFloat = 10.0
        static let contentIndent: CGFloat = 10.0
        static let imageHeight: CGFloat = 200.0
    }
    
    
    
    public init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        setupViewsLayout()
        setupViewsAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Layout

extension SecondView {
    func setupViewsLayout() {
        self.setupScrollViewConstraints()
        self.setupImageViewConstraints()
        self.setupLabelsConstraints()
    }
    
    func setupScrollViewConstraints() {
        self.addSubview(scrollView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupImageViewConstraints() {
        self.scrollView.addSubview(imageView)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentIndent),
            self.imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentIndent),
            self.imageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight)
        ])
    }
    
    func setupLabelsConstraints() {
        self.scrollView.addSubview(titleLabel)
        self.scrollView.addSubview(textLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: Constants.titleDistance),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentIndent),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentIndent),
        ])
        
        NSLayoutConstraint.activate([
            self.textLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Constants.textDistance),
            self.textLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.contentIndent),
            self.textLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.contentIndent),
            self.textLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
    }
}

// MARK: Appearance

extension SecondView {
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
