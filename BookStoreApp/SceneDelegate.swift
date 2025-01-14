//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 13.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return }
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = UINavigationController(rootViewController: TabBarController())
		window?.makeKeyAndVisible()
	}
}
