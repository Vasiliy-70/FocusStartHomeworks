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
    
    enum Constants {
        static let loginFieldDistance: CGFloat = 10.0
        static let passwordFieldDistance: CGFloat = 15.0
        static let keyboardButtonDistance: CGFloat = 10.0
        static let borderSpace: CGFloat = 15.0
        
        static let loginFieldHeight: CGFloat = 50
        static let passwordFieldHeight: CGFloat = 50
        
        static let keyboardButtonHeight: CGFloat = 50
        static let keyboardButtonWidth: CGFloat = 200
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
        
        NSLayoutConstraint.activate([
            self.enterButton.heightAnchor.constraint(equalToConstant: Constants.keyboardButtonHeight),
            self.enterButton.widthAnchor.constraint(equalToConstant: Constants.keyboardButtonWidth),
            self.enterButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.keyboardButtonDistance)
        ])
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
        self.passwordFiled.isHighlighted = true
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
        
        NSLayoutConstraint.deactivate([
            self.enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.keyboardButtonDistance)
        ])
        self.layoutIfNeeded()
        
        UIView.animate(withDuration: 2) {
            NSLayoutConstraint.activate([
                self.enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant:  -keyboardSize.height)
            ])
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("AS")
        UIView.animate(withDuration: 2) {
            NSLayoutConstraint.activate([
                self.enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.keyboardButtonDistance)
            ])
            self.layoutIfNeeded()
        }
        
    }
}

