//
//  BookDetailsViewControllerTests.swift
//  Library
//
//  Created by Thakur, Angita on 5/3/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import XCTest
@testable import Library

class BookDetailsViewControllerTests: XCTestCase {

    var viewController : BookDetailsViewController?

    override open func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "BookDetailsViewController") as? BookDetailsViewController
    }

    // MARK: Tests for Book Details View Controller
    func testForValidBook() {
        givenBookSelected(Book(json: ["id": "xyz",
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
        whenViewLoadedAndAppeared()
        thenBookInformationDisplayed(title: "SOME TITLE", authors: "By: Author 1", categories: "Categories: Category 1", description: "Some description")
    }

    // MARK: Test data setup
    func givenBookSelected(_ book: Book) {
        self.viewController?.book =  book
    }

    // MARK: Test conditions
    func whenViewLoadedAndAppeared() {
        viewController?.loadView()
        viewController?.viewDidLoad()
        viewController?.viewWillAppear(true)
        viewController?.viewDidAppear(true)
    }

    // MARK: Test results
    func thenBookInformationDisplayed(title: String, authors: String, categories: String, description: String) {
        XCTAssertEqual(viewController?.title, title, "Expected title to be \(title) but was \(viewController?.title)")
        XCTAssertEqual(viewController?.bookAuthors.text, authors, "Expected authors to be \(authors) but was \(viewController?.bookAuthors.text)")
        XCTAssertEqual(viewController?.bookCategories.text, categories, "Expected categories to be \(categories) but was \(viewController?.bookCategories.text)")
        XCTAssertEqual(viewController?.bookDescription.text, description, "Expected description to be \(description) but was \(viewController?.bookDescription.text)")
    }
    
}
