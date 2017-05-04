//
//  SearchBooksViewController.swift
//  Library
//
//  Created by Thakur, Angita on 5/1/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import UIKit

class SearchBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let showBookDetailsSegueIdentifier = "showBookDetails"
    @IBOutlet weak var searchBooksTableView: UITableView!
    @IBOutlet weak var blockingView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var books = [Book]()
    var selectedBook: Book?
    var bookApiRequest = BookApiRequest() as BookApiRequestProtocol

    func injectDependencies(bookApiRequest: BookApiRequestProtocol) {
        self.bookApiRequest = bookApiRequest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.searchBooksTableView.register(UINib(nibName: SearchBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchBooksTableViewCell.identifier)
        self.addAccessibilityIdentifiers()
    }

    func addAccessibilityIdentifiers() {
        self.searchBar.accessibilityIdentifier = "SearchBooksViewController.SearchBar"
        self.searchBooksTableView.accessibilityIdentifier = "SearchBooksViewController.SearchBooksTableView"
        self.blockingView.accessibilityIdentifier = "SearchBooksViewController.BlockingView"
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchBooksTableViewCell.identifier, for: indexPath)
        if let searchBooksTableViewCell = cell as? SearchBooksTableViewCell {
            searchBooksTableViewCell.updateCell(withBook: self.books[indexPath.row])
        }
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedBook = books[indexPath.row]
        self.performSegue(withIdentifier: showBookDetailsSegueIdentifier, sender: self)
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
                self.searchBooksTableView.reloadData()
                if self.books.count > 0 {
                    self.searchBooksTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bookDetailsViewController = segue.destination as? BookDetailsViewController else {
            return
        }
        bookDetailsViewController.book = self.selectedBook
    }

}

