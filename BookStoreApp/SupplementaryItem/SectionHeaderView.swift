//
//  SectionHeaderView.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 15.12.2024.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
	static let reuseIdentifier = "SectionHeaderView"
	private let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		label.frame = bounds // Размер лейбла, равень размер самого элемента SectionHeaderView
		label.textAlignment = .left
		label.font = UIFont(name: "Arial Rounded MT Bold", size: 24)
		label.textColor = .white
		addSubview(label)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(text: String) {
		label.text = text
	}
}
