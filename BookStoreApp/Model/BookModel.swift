//
//  BookModel.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 14.12.2024.
//

import Foundation


struct BookType: Hashable {
	let type: String
	var books: [Book]
}

struct Book: Hashable {
	let image: String
	var title: String
	var isNew = false
}
