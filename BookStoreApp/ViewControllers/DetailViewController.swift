//
//  DetailViewController.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 12.01.2025.
//

import UIKit

class DetailViewController: UIViewController {
	
//	var book: Book?
	private let imageView = UIImageView()
	private let infoLable = UILabel()
	private let markButton = UIButton()
	private var toggleButton = false
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
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
		setupNavigationBar()
		infoLable.textAlignment = .center
		infoLable.font = UIFont(name: "Arial Rounded MT Bold", size: 24)
		infoLable.textColor = .white
		view.addSubview(imageView)
		view.addSubview(infoLable)
	}
	
	private func setupNavigationBar() {
		navigationItem.title = "Книги для души"
		
		let mark = "heart.fill"

		navigationItem.rightBarButtonItem = UIBarButtonItem(
			image: UIImage(systemName: mark),
			style: .plain,
			target: self,
			action: #selector(toggleMarkButton)
		)
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
	
	private func setupLayout() {
		[infoLable, imageView].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
		
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
			
			imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
			imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
			imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			
			infoLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
			infoLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			infoLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
			infoLable.heightAnchor.constraint(equalToConstant: 40)
		])
	}
}
