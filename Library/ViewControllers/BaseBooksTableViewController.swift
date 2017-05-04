//
//  BaseBooksTableViewController.swift
//  Library
//
//  Created by Thakur, Angita (ETW) on 5/3/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import UIKit

class BaseBooksTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let showBookDetailsSegueIdentifier = "showBookDetails"
    @IBOutlet weak var booksTableView: UITableView!
    var books = [Book]()
    var selectedBook: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.booksTableView.register(UINib(nibName: SearchBooksTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchBooksTableViewCell.identifier)
        self.addAccessibilityIdentifiers()
    }

    func addAccessibilityIdentifiers() {
        self.booksTableView.accessibilityIdentifier = "BaseBooksTableViewController.SearchBooksTableView"
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bookDetailsViewController = segue.destination as? BookDetailsViewController else {
            return
        }
        bookDetailsViewController.book = self.selectedBook
        bookDetailsViewController.hidesBottomBarWhenPushed = true
    }
    
}
