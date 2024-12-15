//
//  BadgeView.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 15.12.2024.
//

import UIKit

class BadgeView: UICollectionReusableView {
	static let reuseIdentifier = "BadgeView"
	private let badgeLabel = UILabel()
	private let viewContainer = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configureBadge(text: String) {
		badgeLabel.text = text
	}
}

private extension BadgeView {
	func setupView() {
		
		layer.cornerRadius = 5
		backgroundColor = .systemPink
		
		badgeLabel.frame = bounds
		badgeLabel.textColor = .white
		badgeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
		badgeLabel.textAlignment = .center
		addSubview(badgeLabel)
	}
}
