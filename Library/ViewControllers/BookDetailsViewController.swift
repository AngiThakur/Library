//
//  BookDetailsViewController.swift
//  Library
//
//  Created by Thakur, Angita on 5/2/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookThumbnail: UIImageView!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookCategories: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    var book: Book!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = book.title.uppercased()
        self.updateScreen()
    }

    func updateScreen() {
        if let thumbnailUrl = book.thumbnail, let data = try? Data(contentsOf: thumbnailUrl) {
            bookThumbnail.image = UIImage(data: data)
        }
        bookAuthors.text = book.formattedAuthorsString
        bookCategories.text = book.formattedCategoriesString
        bookDescription.text = book.description
    }
    
}
