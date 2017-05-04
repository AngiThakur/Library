//
//  LibraryUITests.swift
//  LibraryUITests
//
//  Created by Thakur, Angita on 5/1/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import XCTest

class LibraryUITests: XCTestCase {

    let searchBar = XCUIApplication().otherElements["SearchBooksViewController.SearchBar"]
    let blockingView = XCUIApplication().otherElements["SearchBooksViewController.BlockingView"]
    let bookToBeSelected = XCUIApplication().tables.staticTexts["Casey at the Bat"]
    let bookDetailPageTitle = XCUIApplication().staticTexts["CASEY AT THE BAT"]

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testBookCanBeSearchedAndViewed() {
        giveBookSearched(withSearchText: "bat")
        whenSearchResultsDisplayed()
        whenABookIsSelected()
        thenBookDetailPageIsDisplayed()
    }

    func giveBookSearched(withSearchText searchText: String) {
        searchBar.tap()
        searchBar.typeText("\(searchText)\r")
    }

    func whenSearchResultsDisplayed() {
        let exists = NSPredicate(format: "exists == false")
        expectation(for: exists, evaluatedWith: blockingView, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
    }

    func whenABookIsSelected() {
        bookToBeSelected.tap()
    }

    func thenBookDetailPageIsDisplayed() {
        XCTAssertTrue(bookDetailPageTitle.exists)
    }
    
}
