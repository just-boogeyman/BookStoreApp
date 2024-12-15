//
//  SectionBackgroundDecorationView.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 15.12.2024.
//

import UIKit

class SectionBackgroundDecorationView: UICollectionReusableView {
	static let reuseIdentifier = "SectionBackgroundDecorationView"
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
		layer.borderColor = UIColor.black.cgColor
		layer.borderWidth = 1
		layer.cornerRadius = 12
	}
}

