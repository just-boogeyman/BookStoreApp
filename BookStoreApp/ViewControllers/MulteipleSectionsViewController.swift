//
//  MulteipleSectionsViewController.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 18.12.2024.
//

import UIKit


class MulteipleSectionViewController: UIViewController {
	private let reuseIdentifier = "reuseIdentifier"
	private var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configureCollectionView()
	}
}

private extension MulteipleSectionViewController {
	func setupView() {
		let layout = createLayout()
		
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		
		collectionView.register(
			SectionHeaderView.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: SectionHeaderView.reuseIdentifier
		)
		
		collectionView.backgroundColor = .white
		collectionView.dataSource = self
		
		view.addSubview(collectionView)
	}
}

private extension MulteipleSectionViewController {
	
	func createLayout() -> UICollectionViewLayout {
		let configuration = UICollectionViewCompositionalLayoutConfiguration()
		configuration.interSectionSpacing = 10
		configuration.boundarySupplementaryItems = [createHeader()]
		
		return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
			if sectionIndex == 0 {
				return self.createTopSection()
			} else if sectionIndex == 1 {
				return self.createMiddleSection()
			} else {
				return self.createBottomSection()
			}
		})
	}
	
	func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let headerSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1.0),
			heightDimension: .absolute(50)
		)
		let header = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top)
		return header
	}
	
	func createTopSection() -> NSCollectionLayoutSection {
		let absolute: CGFloat = 100
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .absolute(absolute),
			heightDimension: .fractionalHeight(1)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .estimated(1),
			heightDimension: .absolute(absolute)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [createHeader()]
		return section
	}
	
	func createMiddleSection() -> NSCollectionLayoutSection {
		let fraction: CGFloat = 1 / 4
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1/3),
			heightDimension: .fractionalHeight(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(fraction)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [createHeader()]
		return section
	}
	
	func createBottomSection() -> NSCollectionLayoutSection {
		let fraction: CGFloat = 1 / 3
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1)
		)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
		
		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(fraction)
		)
		
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
		
		let section = NSCollectionLayoutSection(group: group)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [createHeader()]
		return section
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


extension MulteipleSectionViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		3
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		if indexPath.section == 0 {
			cell.layer.cornerRadius = cell.frame.width / 2
			cell.backgroundColor = .systemCyan
		} else {
			cell.backgroundColor = indexPath.section == 1 ? .systemPurple : .systemTeal
			cell.layer.cornerRadius = 10
		}
		return cell
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		
		if kind == UICollectionView.elementKindSectionHeader {
			let header = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
			header.configure(text: "Section \(indexPath.section + 1)")
			return header
		}
		return UICollectionReusableView()
	}
}
