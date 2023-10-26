//
//  SceneDelegate.swift
//  Bankey
//
//  Created by Diego Sierra on 13/08/23.
//

import UIKit

let appColor: UIColor = .systemTeal

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   
    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.backgroundColor = .systemBackground
            onboardingContainerViewController.delegate = self
            loginViewController.delegate = self
           
            let vc = mainViewController
            vc.setStatusBar()
            
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().backgroundColor = appColor
            window.rootViewController = vc
            window.makeKeyAndVisible()
            
            self.window = window
                
        }
    }
    
}

extension SceneDelegate: LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, LogoutDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(mainViewController)
    }
    
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
    
    func didLogout() {
        setRootViewController(loginViewController)
    }
    
}

extension SceneDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
    }
}

