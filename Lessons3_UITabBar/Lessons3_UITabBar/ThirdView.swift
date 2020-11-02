//
//  ThirdScreen.swift
//  Lessons3_UITabBar
//
//  Created by user183355 on 01.11.2020.
//

import UIKit

final class ThirdView: UIView, UITextFieldDelegate {
    
    // MARK: Properties
    
    private let loginField = UITextField()
    private let passwordFiled = UITextField()
    private let enterButton = UIButton()
    
    private var enterButtonConstraints: [NSLayoutConstraint] = []
    
    enum Constants {
        static let loginFieldDistance: CGFloat = 10.0
        static let passwordFieldDistance: CGFloat = 15.0
        static let enterButtonDistance: CGFloat = 10.0
        static let borderSpace: CGFloat = 15.0
        
        static let loginFieldHeight: CGFloat = 50
        static let passwordFieldHeight: CGFloat = 50
        
        static let enterButtonHeight: CGFloat = 50
        static let enterButtonWidth: CGFloat = 200
    }
    
    public init() {
        super.init(frame: .zero)
                
        self.backgroundColor = .white
        
        self.setViewsLayout()
        self.setViewsAppearance()
        self.setupNotification()
        self.setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        //NSLayoutConstraint.activate([
           // self.enterButton.bottomAnchor.constraint(equalTo: self..bottomAnchor, constant: -Constants.keyboardButtonDistance)
       // ])
    }
}

// MARK: Layout

private extension ThirdView {
    func setViewsLayout() {
        self.setTextFieldsConstraints()
        self.setButtonsConstraints()
    }
    
    func setTextFieldsConstraints() {
        self.addSubview(loginField)
        self.addSubview(passwordFiled)
        
        self.loginField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordFiled.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.loginField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.loginFieldDistance),
            self.loginField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.borderSpace),
            self.loginField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.borderSpace),
            self.loginField.heightAnchor.constraint(equalToConstant: Constants.loginFieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            self.passwordFiled.topAnchor.constraint(equalTo: self.loginField.bottomAnchor, constant: Constants.passwordFieldDistance),
            self.passwordFiled.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constants.borderSpace),
            self.passwordFiled.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.borderSpace),
            self.passwordFiled.heightAnchor.constraint(equalToConstant: Constants.passwordFieldHeight)
        ])
    }
    
    func setButtonsConstraints() {
        self.addSubview(enterButton)
        
        self.enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        enterButtonConstraints.append(contentsOf: [
            self.enterButton.heightAnchor.constraint(equalToConstant: Constants.enterButtonHeight),
            self.enterButton.widthAnchor.constraint(equalToConstant: Constants.enterButtonWidth),
            self.enterButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.enterButton.topAnchor.constraint(greaterThanOrEqualTo: self.passwordFiled.bottomAnchor, constant: Constants.enterButtonDistance),
            
            self.enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.enterButtonDistance)
        ])

        NSLayoutConstraint.activate(enterButtonConstraints)
    }
}

// MARK: Appearance

private extension ThirdView {
    func setViewsAppearance() {
        self.setTextFieldsAppearance()
        self.setButtonsAppearance()
    }
    
    func setTextFieldsAppearance() {
        self.loginField.placeholder = " Login"
        self.loginField.layer.borderWidth = 1
        
        self.passwordFiled.placeholder = " Password"
        self.passwordFiled.layer.borderWidth = 1
        self.passwordFiled.isSecureTextEntry = true
    }
    
    func setButtonsAppearance() {
        self.enterButton.setTitle("Enter", for: .normal)
        self.enterButton.layer.borderWidth = 1
        self.enterButton.backgroundColor = .blue
    }

}

// MARK: Notification

private extension ThirdView {
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: Action

private extension ThirdView {
    func setupAction() {
        self.hideKeyboardWhenTappedArround()
    }
    
    func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        NSLayoutConstraint.deactivate(enterButtonConstraints)

        UIView.animate(withDuration: 2) {
            self.enterButtonConstraints.removeLast()
            self.enterButtonConstraints.append(contentsOf: [
                self.enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant:  -keyboardSize.height)
            ])
            self.enterButtonConstraints[self.enterButtonConstraints.count - 1].priority = UILayoutPriority(rawValue: 750)
            
            NSLayoutConstraint.activate(self.enterButtonConstraints)
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        NSLayoutConstraint.deactivate(enterButtonConstraints)

        UIView.animate(withDuration: 2) {
            self.enterButtonConstraints.removeLast()
            self.enterButtonConstraints.append(contentsOf: [
                self.enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant:  -Constants.enterButtonDistance)
            ])
            
            NSLayoutConstraint.activate(self.enterButtonConstraints)
            self.layoutIfNeeded()
        }
        
    }
}

