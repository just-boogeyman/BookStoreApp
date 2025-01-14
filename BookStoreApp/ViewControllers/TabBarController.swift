//
//  TabBarController.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 14.01.2025.
//

import UIKit


enum TabBarItem {
	case bookVC
	case multeipleVC
	
	var title: String {
		switch self {
		case .bookVC: return "First"
		case .multeipleVC: return "Second"
		}
	}
	
	var icon: UIImage? {
		switch self {
		case .bookVC: return UIImage(systemName: "house.fill")
		case .multeipleVC: return UIImage(systemName: "magnifyingglass")
		}
	}
}

class TabBarController: UITabBarController {
	private let dataSource: [TabBarItem] = [.bookVC, .multeipleVC]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		buildTabBarComponents()
		setupTabBar()
	}
}

private extension TabBarController {
	private func buildTabBarComponents() {
		let bookTypeManager = BookTypeManager()
		viewControllers = dataSource.map {
			switch $0 {
			case .bookVC:
				let vc = BookViewController()
				vc.dataManager = bookTypeManager
				return UINavigationController(rootViewController: vc)
			case .multeipleVC:
				let vc = MulteipleSectionViewController()
				vc.dataManager = bookTypeManager
				return UINavigationController(rootViewController: vc)
			}
		}
	}
	
	private func setupTabBar() { // оставлю комменты ка шпоргалка 
		let appearance = UITabBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .black // Устанавливаем чёрный фон
		
			// Настраиваем цвет для не активной иконки
		appearance.stackedLayoutAppearance.normal.iconColor = .gray
			// Настраиваем цвет для активной иконки
		appearance.stackedLayoutAppearance.selected.iconColor = .white
			// Настраиваем цвет текста не активного title, так же можно задать ему размер и жирность
		appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
			.foregroundColor: UIColor.gray
		]
			// Настраиваем цвет текста активного title
		appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
			.foregroundColor: UIColor.white
		]
		
		// Присваеваем настроенный объект appearance в статичный экран без скролла
		tabBar.standardAppearance = appearance
		// Присваиваем настроенный appearance в экран с скроллом
		tabBar.scrollEdgeAppearance = appearance
		
		viewControllers?.enumerated().forEach { index, viewController in
			viewController.tabBarItem.title = dataSource[index].title
			viewController.tabBarItem.image = dataSource[index].icon
		}
	}
}

