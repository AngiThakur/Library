//
//  BookTests.swift
//  LibraryTests
//
//  Created by Thakur, Angita on 5/1/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Library

class BookTests: XCTestCase {

    var book: Book!
    var bookJSON: JSON!

    override func setUp() {
        super.setUp()
        book = nil
        bookJSON = nil
    }

    // MARK: Tests

    func testShoulDeserializeEmptyResultSet() {
        givenJSON([])
        whenJSONDeserialized()
        thenBookInformation(volumeId: "", title: "", authors:[], description: "", categories: [], smallThumbnail: nil, thumbnail: nil, formattedAuthorsString: "", formattedCategoriesString: "")
    }

    func testShoulDeserializeBook() {
        givenJSON(["id": "xyz",
                   "volumeInfo": [
                    "title": "Some title",
                    "authors": [
                        "Author 1"
                    ],
                    "description": "Some description",
                    "categories": [
                        "Category 1"
                    ],
                    "imageLinks": [
                        "smallThumbnail": "https://someurl.com",
                        "thumbnail": "https://someurl.com"
                    ]]])
        whenJSONDeserialized()
        thenBookInformation(volumeId: "xyz", title: "Some title", authors: ["Author 1"], description: "Some description", categories: ["Category 1"], smallThumbnail: URL(string: "https://someurl.com"), thumbnail: URL(string: "https://someurl.com"), formattedAuthorsString: "By: Author 1", formattedCategoriesString: "Categories: Category 1")
    }

    func testShoulDeserializeBookWithMultipleAuthorsAndCategories() {
        givenJSON(["id": "xyz",
                   "volumeInfo": [
                    "title": "Some title",
                    "authors": [
                        "Author 1",
                        "Author 2"
                    ],
                    "description": "Some description",
                    "categories": [
                        "Category 1",
                        "Category 2"
                    ],
                    "imageLinks": [
                        "smallThumbnail": "https://someurl.com",
                        "thumbnail": "https://someurl.com"
                    ]]])
        whenJSONDeserialized()
        thenBookInformation(volumeId: "xyz", title: "Some title", authors: ["Author 1", "Author 2"], description: "Some description", categories: ["Category 1", "Category 2"], smallThumbnail: URL(string: "https://someurl.com"), thumbnail: URL(string: "https://someurl.com"), formattedAuthorsString: "By: Author 1, Author 2", formattedCategoriesString: "Categories: Category 1, Category 2")
    }


    func testShoulDeserializeNullElements() {
        givenJSON(["id": NSNull(),
                   "volumeInfo": NSNull()])
        whenJSONDeserialized()
        thenBookInformation(volumeId: "", title: "", authors:[], description: "", categories: [], smallThumbnail: nil, thumbnail: nil, formattedAuthorsString: "", formattedCategoriesString: "")
    }

    //MARK: Test data setup

    func givenJSON(_ json: JSON) {
        self.bookJSON = json
    }

    // MARK: Test conditions

    func whenJSONDeserialized() {
        self.book = Book(json: self.bookJSON)
    }

    // MARK: Test results

    func thenBookInformation(volumeId: String, title: String, authors: [String], description: String, categories: [String], smallThumbnail: URL?, thumbnail: URL?, formattedAuthorsString: String, formattedCategoriesString: String) {
        XCTAssertEqual(volumeId, book.volumeId, "Expected volumeId to be \(volumeId) but was \(book.volumeId)")
        XCTAssertEqual(title, book.title, "Expected title to be \(title) but was \(book.title)")
        XCTAssertEqual(authors, book.authors, "Expected authors to be \(authors) but was \(book.authors)")
        XCTAssertEqual(description, book.description, "Expected description to be \(description) but was \(book.description)")
        XCTAssertEqual(categories, book.categories, "Expected categories to be \(categories) but was \(book.categories)")
        XCTAssertEqual(smallThumbnail, book.smallThumbnail, "Expected small thumbnail to be \(smallThumbnail) but was \(book.smallThumbnail)")
        XCTAssertEqual(thumbnail, book.thumbnail, "Expected thumbnail to be \(thumbnail) but was \(book.thumbnail)")
        XCTAssertEqual(formattedAuthorsString, book.formattedAuthorsString, "Expected formatted authors string to be \(formattedAuthorsString) but was \(book.formattedAuthorsString)")
        XCTAssertEqual(formattedCategoriesString, book.formattedCategoriesString, "Expected formatted categories string to be \(formattedCategoriesString) but was \(book.formattedCategoriesString)")
    }
    
}
