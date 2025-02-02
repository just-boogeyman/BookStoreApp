//
//  BadgeViewInfo.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 15.12.2024.
//

import UIKit

final class BadgeViewInfo: UICollectionReusableView {
	static let reuseIdentifier = "BadgeViewInfo"
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

private extension BadgeViewInfo {
	func setupView() {
		badgeLabel.frame = bounds
		badgeLabel.textColor = .white
		badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
		badgeLabel.textAlignment = .left
		addSubview(badgeLabel)
	}
}
