//
//  ViewController.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 13.12.2024.
//

import UIKit

final class BookViewController: UIViewController {
	
	// MARK - Constants
	private enum Constants {
		static let cellIdentifier = "cellIdentifier"
		static let delete = "Удалить"
		static let titleMenu = "Управление"
		static let titleNavigationBar = "Книги для души"
		static let configureBadgeNew = "Новинка"
	}

	private var collectionView: UICollectionView!
	private var diffableDataSource: UICollectionViewDiffableDataSource<BookType, Book>!
	
	var dataManager: IBookManager!

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configureCollectionView()
		configureDataSource()
		applyInitialData()
	}
}

private extension BookViewController {
	func setupView() {
		registerView()
		setupNavigationBar()
		collectionView.backgroundColor = .black
		collectionView.delegate = self
		
		view.addSubview(collectionView)
	}
	
	//MARK: - Setup Navigation
	func setupNavigationBar() {
		navigationItem.title = Constants.titleNavigationBar

		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let apperance = UINavigationBarAppearance()
		
		apperance.configureWithOpaqueBackground()
		apperance.backgroundColor = .black
		
		apperance.titleTextAttributes = [
			.foregroundColor: UIColor.white,
			.font: UIFont.systemFont(ofSize: 18, weight: .bold)
		]
		
		apperance.largeTitleTextAttributes = [
			.foregroundColor: UIColor.white,
			.font: UIFont.systemFont(ofSize: 34, weight: .bold)
		]
		
		navigationController?.navigationBar.standardAppearance = apperance
		navigationController?.navigationBar.scrollEdgeAppearance = apperance
	}
	
	func registerView() {
		let layout = createLayout()

		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
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

private extension BookViewController {
	func configureDataSource() {
		diffableDataSource = UICollectionViewDiffableDataSource(
			collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
				let book = self.dataManager.getBookType()[indexPath.section].books[indexPath.row]
				guard let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: Constants.cellIdentifier,
					for: indexPath)
					as? CustomCollectionViewCell else { return UICollectionViewCell() }
				cell.configure(with: book.image)
				cell.settingRadius(radius: 5)
				return cell
		}
		
		diffableDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
			let bookType = self.dataManager.getBookType()
			let book = bookType[indexPath.section].books[indexPath.row]

			if kind == UICollectionView.elementKindSectionHeader {
				let header = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier,
					for: indexPath) as! SectionHeaderView
				header.configure(text: "\(bookType[indexPath.section].type)")
				return header
			} else if kind == ElementKind.badge {
				let badge = collectionView.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: BadgeView.reuseIdentifier,
					for: indexPath) as! BadgeView
				badge.configureBadge(text: Constants.configureBadgeNew)
				badge.isHidden = !book.isNew
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
	
	func applyInitialData() {
		var snapshot = NSDiffableDataSourceSnapshot<BookType, Book>()
		
		let sections = dataManager.getBookType()
		snapshot.appendSections(sections)
		
		for items in sections {
			snapshot.appendItems(items.books, toSection: items)
		}
		
		diffableDataSource.apply(snapshot, animatingDifferences: true)
	}
	
	func setupMenu(menuButton: MenuButton, indexPath: IndexPath) {
		switch menuButton {
		case .delete:
			dataManager.removeBook(section: indexPath.section, item: indexPath.item)
		case .new:
			dataManager.markIsNew(indexPath: indexPath)
		case .top:
			dataManager.moveTop(indexPath: indexPath)
		case .copy:
			dataManager.copyBook(indexPath: indexPath)
		}
	}
}

// MARK: - UICollectionViewDelegate
extension BookViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let detailVC = DetailViewController()
		let bookType = dataManager.getBookType()
		let book = bookType[indexPath.section].books[indexPath.row]
		detailVC.configure(book: book)
		
		navigationController?.pushViewController(detailVC, animated: true)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		contextMenuConfigurationForItemsAt indexPaths: [IndexPath],
		point: CGPoint
	) -> UIContextMenuConfiguration? {
		
		UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
			
			let actions = MenuButton.allCases
			
			let uiActions = actions.map { action in
				UIAction(
					title: action.title,
					image: action.icon,
					attributes: action.title == Constants.delete ? .destructive : []
				) { _ in
					collectionView.performBatchUpdates {
						for indexPath in indexPaths {
							self.setupMenu(menuButton: action, indexPath: indexPath)
						}
						self.applyInitialData()
					}
				}
			}
			return UIMenu(title: Constants.titleMenu, children: uiActions)
		}
	}
}

private extension BookViewController {
	
	//MARK: - ElementKind
	enum ElementKind {
		static let background = "section-background-element-kind"
		static let badge = "badge-element-kind"
		static let badgeInfo = "badge-element-info-kind"
	}
	
	//MARK: - MenuButton
	enum MenuButton: CaseIterable {
		case new
		case top
		case copy
		case delete
		
		var title: String {
			switch self {
			case .delete: return "Удалить"
			case .new: return "Новинка"
			case .top: return "Перенести в начало"
			case .copy: return "Копировать"
			}
		}
		
		var icon: UIImage? {
			switch self {
			case .new:
				UIImage(resource: .heart)
			case .top:
				UIImage(systemName: "arrowshape.turn.up.left")
			case .copy:
				UIImage(resource: .copy)
			case .delete:
				UIImage(systemName: "trash")
			}
		}
	}
}
