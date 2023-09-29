//
//  DummyViewController.swift
//  Bankey
//
//  Created by Diego Sierra on 25/09/23.
//

import UIKit

class DummyViewController: UIViewController {
    weak var logoutDelegate: LogoutDelegate?
    
    let stackView = UIStackView()
    let label = UILabel()
    let logOutButton = UIButton(type: .system )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension DummyViewController {
    func style () {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.configuration = .filled()
        logOutButton.setTitle("Logout", for: [])
        logOutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logOutButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension DummyViewController {
    @objc func logoutButtonTapped() {
        logoutDelegate?.didLogout()
    }
}

