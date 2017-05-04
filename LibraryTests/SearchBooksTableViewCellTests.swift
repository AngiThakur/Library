//
//  SearchBooksTableViewCellTests.swift
//  Library
//
//  Created by Thakur, Angita on 5/2/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import Foundation
import XCTest
@testable import Library

class SearchBooksTableViewCellTests: XCTestCase {

    var searchBooksTableViewCell: SearchBooksTableViewCell?
    var book: Book?

    override func setUp(){
        super.setUp()
        searchBooksTableViewCell = UINib(nibName: SearchBooksTableViewCell.identifier, bundle:  Bundle.main).instantiate(withOwner: self, options: nil).first as? SearchBooksTableViewCell
    }

    override func tearDown(){
        super.tearDown()
    }

    //MARK: Tests for Search Books Table View Cell
    func testShouldShowEmptyOrder(){
        givenBook(Book(json: []))
        whenSearchBooksTableViewCellUpdated()
        thenSearchBooksTableViewCellData(title: "", author: "", description: "")
    }

    func testShouldShowBookWithOneAuthor(){
        givenBook(Book(json: ["id": "xyz",
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
                                ]]]))
        whenSearchBooksTableViewCellUpdated()
        thenSearchBooksTableViewCellData(title: "Some title", author: "By: Author 1", description: "Some description")
    }

    func testShouldShowBookWithTwoAuthors(){
        givenBook(Book(json: ["id": "xyz",
                              "volumeInfo": [
                                "title": "Some title",
                                "authors": [
                                    "Author 1",
                                    "Author 2"
                                ],
                                "description": "Some description",
                                "categories": [
                                    "Category 1"
                                ],
                                "imageLinks": [
                                    "smallThumbnail": "https://someurl.com",
                                    "thumbnail": "https://someurl.com"
                                ]]]))
        whenSearchBooksTableViewCellUpdated()
        thenSearchBooksTableViewCellData(title: "Some title", author: "By: Author 1, Author 2", description: "Some description")
    }

    //MARK: Test data setup
    func givenBook(_ book : Book){
        self.book = book
    }

    //MARK: Test conditions
    func whenSearchBooksTableViewCellUpdated(){
        searchBooksTableViewCell?.updateCell(withBook: self.book!)
    }

    //MARK: Test results
    func thenSearchBooksTableViewCellData(title: String, author: String, description: String) {
        XCTAssertEqual(searchBooksTableViewCell!.bookTitle.text , title, "Expected title to be \(title) but was \(searchBooksTableViewCell!.bookTitle.text)")
        XCTAssertEqual(searchBooksTableViewCell!.bookAuthors.text , author, "Expected author to be \(author) but was \(searchBooksTableViewCell!.bookAuthors.text)")
        XCTAssertEqual(searchBooksTableViewCell!.bookDescription.text , description, "Expected description to be \(description) but was \(searchBooksTableViewCell!.bookDescription.text)")
    }
}
