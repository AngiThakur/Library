//
//  BookApiRequest.swift
//  Library
//
//  Created by Thakur, Angita on 5/1/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol BookApiRequestProtocol {

     func getBooks(forSearchText searchText: String, success: @escaping([Book]) -> Void, failure: @escaping(String) -> Void)

}

class BookApiRequest: BookApiRequestProtocol {

    let urlSession: URLSession!

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    private func getBookSearchUrl(searchText: String) -> URL? {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(searchText.replacingOccurrences(of: " ", with: "%20"))&maxResults=20"
        return URL(string: urlString)
    }

    func getBooks(forSearchText searchText: String, success: @escaping([Book]) -> Void, failure: @escaping(String) -> Void) {
        guard let bookSearchUrl = getBookSearchUrl(searchText: searchText) else {
            failure("Wrong url")
            return
        }
        let task = urlSession.dataTask(with: bookSearchUrl) { data, response, error in
            guard let data = data, error == nil else {
                failure(error?.localizedDescription ?? "Response is nil")
                return
            }
            let json = JSON(data: data)
            var books = [Book]()
            for item in json["items"].arrayValue {
                let book = Book(json: item)
                books.append(book)
            }
            success(books)
        }
        task.resume()
    }

}
