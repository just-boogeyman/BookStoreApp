//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 13.12.2024.
//

import UIKit

enum Scene {
	case bookView
	case multeipleSection
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else { return }
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = assembly(scene: .multeipleSection)
		window?.makeKeyAndVisible()
	}
}

extension SceneDelegate {
	func assembly(scene: Scene) -> UIViewController {
		switch scene {
		case .bookView:
			let bookTypeManager = BookTypeManager()
			let vc = BookViewController()
			vc.dataManager = bookTypeManager
			return vc
		case .multeipleSection:
			return MulteipleSectionViewController()
		}
	}
}
