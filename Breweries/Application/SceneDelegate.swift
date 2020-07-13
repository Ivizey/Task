//
//  SceneDelegate.swift
//  Breweries
//
//  Created by Pavel Bondar on 15.04.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let charter = UIFontDescriptor(name: "Charter", size: 24)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(descriptor: charter, size: 24),
            .foregroundColor: UIColor.white,
        ]
        
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.238032639, green: 0.5622211695, blue: 0.05326066166, alpha: 1)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = attributes
        
        let assemblyBuilder = AsselderModuleBuilder()
        let router = Router(navigationController: navigationController, asseblyBuilder: assemblyBuilder)
        router.initialViewController()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
