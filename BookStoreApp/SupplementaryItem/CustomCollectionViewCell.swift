//
//  CustomCollectionViewCell.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 15.12.2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
	
	private let imageView = UIImageView()
	private let viewContainer = UIView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupLayout()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with imageName: String) {
		imageView.image = UIImage(named: imageName)
	}
}

extension CustomCollectionViewCell {
	private func setupViews() {
		contentView.addSubview(viewContainer)
		viewContainer.addSubview(imageView)
	}
}

extension CustomCollectionViewCell {
	func setupLayout() {
		viewContainer.translatesAutoresizingMaskIntoConstraints = false
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
			viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			
			imageView.topAnchor.constraint(equalTo: viewContainer.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
		])
	}
}
