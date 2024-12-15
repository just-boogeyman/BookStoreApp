//
//  ViewController.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 13.12.2024.
//

import UIKit

class BookViewController: UIViewController {
	private let cellIdentifier = "cellIdentifier"
	private var collectionView: UICollectionView!
	
	var dataManager: IBookTypeManager!

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configureCollectionView()
	}
}

private extension BookViewController {
	func setupView() {
		registerView()
		collectionView.backgroundColor = .black
		collectionView.dataSource = self
		view.addSubview(collectionView)
	}
	
	func registerView() {
		let layout = createLayout()

		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
		collectionView.register(
			SectionHeaderView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: SectionHeaderView.reuseIdentifier
		)

		collectionView.register(
			BadgeView.self,
			forSupplementaryViewOfKind: ElementKind.badge,
			withReuseIdentifier: BadgeView.reuseIdentifier
		)
		
		collectionView.register(
			BadgeViewInfo.self,
			forSupplementaryViewOfKind: ElementKind.badgeInfo,
			withReuseIdentifier: BadgeViewInfo.reuseIdentifier
		)
	}
}

// MARK: - Settings Layout
private extension BookViewController {
	func createLayout() -> UICollectionViewLayout {
		
		let supplementaryItem = createSupplementary()
		let bageInfoItem = createBageInfo()
		
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [supplementaryItem, bageInfoItem])
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
		// Создаём группу
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.6),
			heightDimension: .fractionalHeight(0.25)
		)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let headerSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .absolute(50)
		)
		
		let header = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .topLeading
		)
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 40, trailing: 10)
		section.boundarySupplementaryItems = [header]

		return UICollectionViewCompositionalLayout(section: section)
	}
	
	func createSupplementary() -> NSCollectionLayoutSupplementaryItem {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(100),
			heightDimension: .absolute(20)
		)
		
		let constraints = NSCollectionLayoutAnchor(
			edges: [.top, .leading],
			absoluteOffset: CGPoint(x: 0, y: -20)
		)
		
		let item = NSCollectionLayoutSupplementaryItem(
			layoutSize: itemSize,
			elementKind: ElementKind.badge,
			containerAnchor: constraints
		)
		
		return item
	}
	
	func createBageInfo() -> NSCollectionLayoutSupplementaryItem {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(170),
			heightDimension: .absolute(20)
		)
		
		let constraints = NSCollectionLayoutAnchor(
			edges: [.bottom, .leading],
			absoluteOffset: CGPoint(x: 0, y: 30)
		)
		
		let item = NSCollectionLayoutSupplementaryItem(
			layoutSize: itemSize,
			elementKind: ElementKind.badgeInfo,
			containerAnchor: constraints
		)
		return item
	}
	
	func configureCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

extension BookViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		dataManager.getBookTypes().count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let books = dataManager.getBookTypes()[section].books
		return books.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let book = dataManager.getBookTypes()[indexPath.section].books[indexPath.row]
		guard
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: cellIdentifier,
				for: indexPath
			) as? CustomCollectionViewCell else { return UICollectionViewCell() }
		
		cell.configure(with: book.image)

		return cell
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		let bookType = dataManager.getBookTypes()
		let book = bookType[indexPath.section].books[indexPath.row]

		if kind == UICollectionView.elementKindSectionHeader {
			let header = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
			header.configure(text: "\(bookType[indexPath.section].type)")
			return header
		} else if kind == ElementKind.badge {
			let badge = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: BadgeView.reuseIdentifier,
				for: indexPath) as! BadgeView
			if book.isNew {
				badge.configureBadge(text: "Новинка")
				badge.isHidden = false
			} else {
				badge.isHidden = true
			}
			return badge
		} else if kind == ElementKind.badgeInfo {
			let infoBadge = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: BadgeViewInfo.reuseIdentifier,
				for: indexPath) as! BadgeViewInfo
			infoBadge.configureBadge(text: book.title)
			return infoBadge
		}
		return UICollectionReusableView()
	}
}


extension BookViewController {
	enum ElementKind {
		static let background = "section-background-element-kind"
		static let badge = "badge-element-kind"
		static let badgeInfo = "badge-element-info-kind"
	}
}
