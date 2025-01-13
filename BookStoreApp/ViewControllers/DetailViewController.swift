//
//  DetailViewController.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 12.01.2025.
//

import UIKit

class DetailViewController: UIViewController {
	
	private let imageView = UIImageView()
	private let infoLable = UILabel()
	private let markButton = UIButton()
	private var toggleButton = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupLayout()
	}
	
	func configure(book: Book) {
		imageView.image = UIImage(named: book.image)
		infoLable.text = book.title
	}
	
	@objc
	private func toggleMarkButton() {
		toggleButton.toggle()
		let mark = toggleButton ? "heart" : "heart.fill"
		navigationItem.rightBarButtonItem?.image = UIImage(systemName: mark)
	}
}

extension DetailViewController {
	
	private func setupView() {
		infoLable.textAlignment = .center
		infoLable.font = UIFont(name: "Arial Rounded MT Bold", size: 24)
		infoLable.textColor = .white
		view.addSubview(imageView)
		view.addSubview(infoLable)
	}

	
	private func setupLayout() {
		[infoLable, imageView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
			imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
			imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			
			infoLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
			infoLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			infoLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
			infoLable.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}
