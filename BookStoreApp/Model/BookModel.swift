//
//  BookModel.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 14.12.2024.
//

import Foundation


struct BookType {
	let type: String
	let books: [Book]
}

struct Book {
	let image: String
	let title: String
	var isNew = false
}
