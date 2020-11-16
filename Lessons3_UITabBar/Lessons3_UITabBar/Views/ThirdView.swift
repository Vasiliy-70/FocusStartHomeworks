//
//  ThirdScreen.swift
//  Lessons3_UITabBar
//
//  Created by user183355 on 01.11.2020.
//

import UIKit

final class ThirdView: UIView, UITextFieldDelegate {
    
    // MARK: Properties
    
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let enterButton = UIButton()
    
    private var enterButtonConstraints: [NSLayoutConstraint] = []
    
    enum Constants {
        static let loginTextFieldDistance: CGFloat = 10.0
        static let passwordTextFieldDistance: CGFloat = 15.0
        static let enterButtonDistance: CGFloat = 10.0
        static let borderSpace: CGFloat = 15.0
        
        static let loginTextFieldBorderWidth: CGFloat = 1
        static let passwordTextFieldBorderWidth: CGFloat = 1
        static let enterButtonBorderWidth: CGFloat = 1
        
        static let loginTextFieldHeight: CGFloat = 50
        static let passwordTextFieldHeight: CGFloat = 50
        
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
}

// MARK: Layout

private extension ThirdView {
    func setViewsLayout() {
        self.setTextFieldsConstraints()
        self.setButtonsConstraints()
    }
    
    func setTextFieldsConstraints() {
        self.addSubview(loginTextField)
        self.addSubview(passwordTextField)
        
        self.loginTextField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.loginTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                 constant: Constants.loginTextFieldDistance),
            self.loginTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                     constant: Constants.borderSpace),
            self.loginTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -Constants.borderSpace),
            self.loginTextField.heightAnchor.constraint(equalToConstant: Constants.loginTextFieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            self.passwordTextField.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor,
                                                    constant: Constants.passwordTextFieldDistance),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: Constants.borderSpace),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                         constant: -Constants.borderSpace),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: Constants.passwordTextFieldHeight)
        ])
    }
    
    func setButtonsConstraints() {
        self.addSubview(enterButton)
        
        self.enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.enterButtonConstraints.append(contentsOf: [
            self.enterButton.heightAnchor.constraint(equalToConstant: Constants.enterButtonHeight),
            self.enterButton.widthAnchor.constraint(equalToConstant: Constants.enterButtonWidth),
            self.enterButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.enterButton.topAnchor.constraint(greaterThanOrEqualTo: self.passwordTextField.bottomAnchor,
                                                  constant: Constants.enterButtonDistance),
            
            self.enterButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: -Constants.enterButtonDistance)
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
        self.loginTextField.placeholder = " Login"
        self.loginTextField.layer.borderWidth = Constants.loginTextFieldBorderWidth
        
        self.passwordTextField.placeholder = " Password"
        self.passwordTextField.layer.borderWidth = Constants.passwordTextFieldBorderWidth
        self.passwordTextField.isSecureTextEntry = true
    }
    
    func setButtonsAppearance() {
        self.enterButton.setTitle("Enter", for: .normal)
        self.enterButton.layer.borderWidth = Constants.enterButtonBorderWidth
        self.enterButton.backgroundColor = .blue
    }

}

// MARK: Notification

private extension ThirdView {
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: Action

private extension ThirdView {
    func setupAction() {
        self.hideKeyboardWhenTappedArround()
    }
    
    func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(self.hideKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        NSLayoutConstraint.deactivate(self.enterButtonConstraints)

        UIView.animate(withDuration: 2) { [weak self] in
			guard let optionalSelf = self else { return }
			optionalSelf.enterButtonConstraints.removeLast()
			optionalSelf.enterButtonConstraints.append(optionalSelf.enterButton.bottomAnchor.constraint(equalTo: optionalSelf.safeAreaLayoutGuide.bottomAnchor, constant:  -keyboardSize.height))
			optionalSelf.enterButtonConstraints.last?.priority = UILayoutPriority(rawValue: 750)
            
            NSLayoutConstraint.activate(optionalSelf.enterButtonConstraints)
			optionalSelf.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        NSLayoutConstraint.deactivate(self.enterButtonConstraints)
        
        UIView.animate(withDuration: 2) { [weak self] in
            guard let optionalSelf = self else { return }
			optionalSelf.enterButtonConstraints.removeLast()
			optionalSelf.enterButtonConstraints.append(optionalSelf.enterButton.bottomAnchor.constraint(equalTo: optionalSelf.safeAreaLayoutGuide.bottomAnchor, constant:  -Constants.enterButtonDistance))
            NSLayoutConstraint.activate(optionalSelf.enterButtonConstraints)
			optionalSelf.layoutIfNeeded()
        }
    }
}


