//
//  SearchBooksViewControllerTests.swift
//  Library
//
//  Created by Thakur, Angita on 5/3/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Library

class SearchBooksViewControllerTests: XCTestCase {

    var viewController : SearchBooksViewController?
    var fakeBookApiRequest = FakeBookApiRequest()

    override open func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "SearchBooksViewController") as? SearchBooksViewController
        viewController!.injectDependencies(bookApiRequest: fakeBookApiRequest)
        viewController!.loadView()
    }

    // MARK: Tests for Search Books View Controller
    func testForTwoBooksFound() {
        givenBooksSearchRepsonseReturned(booksJson: ["items": [["id": "xyz"], ["id": "abc"]]])
        whenViewLoadedAndAppeared()
        whenSearchPerformed("abc")
        thenNumberOfRowsDisplayed(expected: 2)
    }

    // MARK: Test data setup
    func givenBooksSearchRepsonseReturned(booksJson : JSON? = nil, isSuccess: Bool = true) {
        fakeBookApiRequest.booksJson = booksJson
        fakeBookApiRequest.isSuccess = isSuccess
    }

    // MARK: Test conditions
    func whenViewLoadedAndAppeared() {
        viewController!.viewDidLoad()
        viewController!.viewWillAppear(true)
        viewController!.viewDidAppear(true)
    }

    func whenSearchPerformed(_ searchTerm : String) {
        viewController!.searchBar.text = searchTerm
        viewController!.searchBarSearchButtonClicked(viewController!.searchBar)
    }

    // MARK: Test results
    func thenNumberOfRowsDisplayed(expected: Int) {
        XCTAssertEqual(viewController!.searchBooksTableView.numberOfRows(inSection: 0), expected,  "Expected number of rows to be \(expected) but was \(viewController!.searchBooksTableView.numberOfRows(inSection: 0))")
    }

}
