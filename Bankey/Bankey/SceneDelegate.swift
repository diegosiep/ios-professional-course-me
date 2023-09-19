//
//  SceneDelegate.swift
//  Bankey
//
//  Created by Diego Sierra on 13/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = OnboardingContainerViewController()
            window.backgroundColor = .systemBackground
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}

