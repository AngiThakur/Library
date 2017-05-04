//
//  SearchBooksTableViewCell.swift
//  Library
//
//  Created by Thakur, Angita on 5/1/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import UIKit

class SearchBooksTableViewCell: UITableViewCell {

    static let identifier = "SearchBooksTableViewCell"

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookDescription: UILabel!

    func updateCell(withBook book: Book) {
        if let smallThumbnailUrl = book.smallThumbnail, let data = try? Data(contentsOf: smallThumbnailUrl) {
            bookImage.image = UIImage(data: data)
        }
        self.bookTitle.text = book.title
        self.bookAuthors.text = book.formattedAuthorsString
        self.bookDescription.text = book.description
    }

}
