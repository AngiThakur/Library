//
//  BookApiRequestTests.swift
//  Library
//
//  Created by Thakur, Angita on 5/2/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Library

class BookApiRequestTests: XCTestCase {

    var bookApiRequest: BookApiRequest!
    var mockURLSession = MockURLSession()

    override func setUp() {
        super.setUp()
        bookApiRequest = BookApiRequest(urlSession: mockURLSession)
    }

    // MARK: Tests

    func testBookListIsEmpty() {
        givenServiceResponse(["items": []])
        thenBookCount(0)
    }

    func testBooksAreEmpty() {
        givenServiceResponse(["items": [[], []]])
        thenBookCount(2)
        thenFirstBookVolumeId("")
    }

    func testValidBooks() {
        givenServiceResponse(["items": [["id": "xyz",
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
                                            ]]]]])
        thenBookCount(1)
        thenFirstBookVolumeId("xyz")
    }

    // MARK: Test data setup

    func givenServiceResponse(_ response: JSON, isSuccess: Bool? = true) {
        mockURLSession.response = response
        mockURLSession.isSuccess = isSuccess!
    }

    // MARK: Test results

    func thenBookCount(_ expected : Int) {
        bookApiRequest.getBooks(forSearchText: "abc", success: { books in
            XCTAssertEqual(books.count, expected, "Expected number of books to be \(expected) but was \(books.count)")
        }, failure: {_ in
            XCTFail("Service failed when expected a success")
        })
    }

    func thenFirstBookVolumeId(_ expected: String) {
        bookApiRequest.getBooks(forSearchText: "abc", success: { books in
            XCTAssertEqual(books.first?.volumeId, expected, "Expected first book volume id to be \(expected) but was \(books.first?.volumeId)")
        }, failure: {_ in
            XCTFail("Service failed when expected a success")
        })
    }

}
