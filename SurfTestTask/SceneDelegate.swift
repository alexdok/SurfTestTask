//
//  SceneDelegate.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 01.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow.init(windowScene: windowScene)
        let navigationController = UINavigationController.init(rootViewController: MyViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
