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
        
        window = UIWindow(windowScene: windowScene)

        let dataProvider: DataProvider

        if usingHardcodedValues {
            dataProvider = DataProviderHardcodedImpl()
        } else {
            dataProvider = DataProviderUserDefaultsImpl(userDefaults: .standard)
        }

        let resumeViewController = ResumeViewController(alertBuilder: AlertBuilderImpl(), dataProvider: dataProvider)
        let navigationController = UINavigationController(rootViewController: resumeViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

private var usingHardcodedValues = true
