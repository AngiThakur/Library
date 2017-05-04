//
//  FakeBookApiRequest.swift
//  Library
//
//  Created by Thakur, Angita on 5/3/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import SwiftyJSON
@testable import Library

class FakeBookApiRequest: BookApiRequestProtocol {

    var booksJson: JSON?
    var isSuccess = true
    var errorMessage = "Testing failure through unit tests"

    func getBooks(forSearchText searchText: String, success: @escaping([Book]) -> Void, failure: @escaping(String) -> Void) {
        if isSuccess {
            guard let json = booksJson else {
                failure("Nil Json")
                return
            }
            var books = [Book]()
            for item in json["items"].arrayValue {
                let book = Book(json: item)
                books.append(book)
            }
            success(books)
        }
        else {
            failure(errorMessage)
        }
    }
    
}
