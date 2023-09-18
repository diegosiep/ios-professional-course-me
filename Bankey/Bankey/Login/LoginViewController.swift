//
//  ViewController.swift
//  Bankey
//
//  Created by Diego Sierra on 13/08/23.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let signInButton = UIButton()
    let errorMessageLabel = UILabel()
    let appTitleLabel = UILabel()
    let sloganLabel = UILabel()
    
    var username: String? {
        return loginView.userNameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension LoginViewController {
    private func style() {
        
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        appTitleLabel.textAlignment = .center
        appTitleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        appTitleLabel.text = "Bankey"
        
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        sloganLabel.numberOfLines = 0
        sloganLabel.textAlignment = .center
        sloganLabel.font = .systemFont(ofSize: 18, weight: .regular)
        sloganLabel.text = "Your premium source for all things banking!"
        sloganLabel.adjustsFontForContentSizeCategory = true
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "Error message"
        errorMessageLabel.isHidden = true
        
        
    }
    
    private func layout() {
        view.addSubview(appTitleLabel)
        view.addSubview(sloganLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //        Always remember the reference for setting up new anchors for new views, has to be the initial anchors(s) set up for the first setup view --> particularly applies in the following example, where you'd want a button to always layout right after the bottom anchor of the loginView. For any other view(s) added after that, the last previous configured view must be used to establish layout constraints properly (i.e., instead of the initial anchor for the initial or first added view, you should choose the constratint reference for the very last view you configured).
        
//        TItle and slogan labels
        NSLayoutConstraint.activate([
            appTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sloganLabel.topAnchor.constraint(equalToSystemSpacingBelow: appTitleLabel.bottomAnchor, multiplier: 3),
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: sloganLabel.bottomAnchor, multiplier: 3),
            sloganLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            sloganLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            
        ])
        
        
        
        
        //        LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        //        SignInButton
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1),
            //            or --> signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //        ErrorMessageLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            errorMessageLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
            //            or --> view.trailingAnchor.constraint(equalToSystemSpacingAfter: errorMessageLabel.trailingAnchor, multiplier: 1)
        ])
        
        
        
    }
}

extension LoginViewController {
    @objc func signInTapped() {
        errorMessageLabel.isHidden = true
        login()
    }
    
    func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}

