//
//  SceneDelegate.swift
//  Lessons4_SplitViewController
//
//  Created by user183355 on 07.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let splitViewController = window?.rootViewController as? MainSplitViewController,
              let navigationController = splitViewController.viewControllers.first as? UINavigationController,
              let masterViewController = navigationController.topViewController as? MasterViewController,
              let detailViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? DetailViewController
        else { assertionFailure(); return }
        
        masterViewController.delegate = detailViewController
        
        let defaultItem = masterViewController.menuData[0]
        detailViewController.dataModel = defaultItem
    }
}

