//
//  SearchBooksViewController.swift
//  Library
//
//  Created by Thakur, Angita on 5/1/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import UIKit

class SearchBooksViewController: BaseBooksTableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var blockingView: UIView!
    var bookApiRequest = BookApiRequest() as BookApiRequestProtocol

    func injectDependencies(bookApiRequest: BookApiRequestProtocol) {
        self.bookApiRequest = bookApiRequest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addAccessibilityIdentifiers()
    }

    override func addAccessibilityIdentifiers() {
        self.searchBar.accessibilityIdentifier = "SearchBooksViewController.SearchBar"
        self.blockingView.accessibilityIdentifier = "SearchBooksViewController.BlockingView"
    }

    // MARK: - UISearchBarDelegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        blockingView.isHidden = false
        searchBar.text = ""
        bookApiRequest.getBooks(forSearchText: searchText, success: { books in
            self.books = books
            DispatchQueue.main.async {
                self.booksTableView.reloadData()
                if self.books.count > 0 {
                    self.booksTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
                self.blockingView.isHidden = true
            }
        }, failure: { error in
            print(error)
            DispatchQueue.main.async {
                self.blockingView.isHidden = true
            }
        })
    }

}

