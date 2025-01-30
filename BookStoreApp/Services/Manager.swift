//
//  Manager.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 30.01.2025.
//

import Foundation



protocol IBookManager {
	func removeBook(section: Int, item: Int)
	func getBookType() -> [BookType]
	func markIsNew(indexPath: IndexPath)
	func moveTop(indexPath: IndexPath)
	func copyBook(indexPath: IndexPath)
}


final class BookManager {
	private var bookTypes: [BookType]
	
	init(bookTypes: [BookType]) {
		self.bookTypes = bookTypes
	}
}

extension BookManager: IBookManager {
	func copyBook(indexPath: IndexPath) {
		var book = bookTypes[indexPath.section].books[indexPath.row]
		book.title = "\(book.title)" + "1"
		bookTypes[indexPath.section].books.insert(book, at: 0)
	}
	
	func moveTop(indexPath: IndexPath) {
		let book = bookTypes[indexPath.section].books.remove(at: indexPath.item)
		bookTypes[indexPath.section].books.insert(book, at: 0)
	}
	
	func markIsNew(indexPath: IndexPath) {
		bookTypes[indexPath.section].books[indexPath.row].isNew = true
	}
	
	func getBookType() -> [BookType] {
		bookTypes
	}
	
	func removeBook(section: Int, item: Int) {
		bookTypes[section].books.remove(at: item)
	}
}
