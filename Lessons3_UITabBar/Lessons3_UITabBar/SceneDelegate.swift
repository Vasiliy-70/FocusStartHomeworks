//
//  SceneDelegate.swift
//  Homework-3_UITabBar
//
//  Created by user183355 on 31.10.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return assertionFailure() }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        guard let window = window else { return assertionFailure() }
        window.windowScene = windowScene
        
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

