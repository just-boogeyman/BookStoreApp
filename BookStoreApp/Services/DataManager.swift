//
//  DataManager.swift
//  BookStoreApp
//
//  Created by Ярослав Кочкин on 14.12.2024.
//

import Foundation


protocol IBookTypeManager {
	func getBookTypes() -> [BookType]
}

class BookTypeManager {}

extension BookTypeManager: IBookTypeManager {
	func getBookTypes() -> [BookType] {
		[
			BookType(type: "Выбор редакции", books: [
				Book(image: "book1", title: "Подводное бормотание", isNew: true),
				Book(image: "book2", title: "Один в поле воен", isNew: true),
				Book(image: "book3", title: "Мне ничего не жаль"),
				Book(image: "book4", title: "Кто ты воин?", isNew: true),
				Book(image: "book5", title: "Можно я с тобой?")
			]),
			BookType(type: "Новинки в подписке", books: [
				Book(image: "book6", title: "Мы все сможем"),
				Book(image: "book7", title: "Мотивация"),
				Book(image: "book8", title: "Деградация", isNew: true),
				Book(image: "book9", title: "Параллельные прямые")
			])
		]
	}
}
