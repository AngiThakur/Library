//
//  BookDetailsViewController.swift
//  Library
//
//  Created by Thakur, Angita on 5/2/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookThumbnailImageView: UIImageView!
    @IBOutlet weak var bookAuthorsLabel: UILabel!
    @IBOutlet weak var bookCategoriesLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var addOrRemoveFromFavoritesButton: UIButton!
    var book: Book!

    var favoriteBooks : [Book] {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).favoriteBooks
        }
        set {
            (UIApplication.shared.delegate as! AppDelegate).favoriteBooks = newValue
        }
    }

    var isFavorite: Bool {
        return favoriteBooks.filter({$0.volumeId == book.volumeId}).count > 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = book.title.uppercased()
        self.updateScreen()
    }

    func updateScreen() {
        if let thumbnailUrl = book.thumbnail, let data = try? Data(contentsOf: thumbnailUrl) {
            bookThumbnailImageView.image = UIImage(data: data)
        }
        bookAuthorsLabel.text = book.formattedAuthorsString
        bookCategoriesLabel.text = book.formattedCategoriesString
        bookDescriptionLabel.text = book.description
        if isFavorite {
            addOrRemoveFromFavoritesButton.setTitle("Remove From Favorites", for: .normal)
        }
        else {
            addOrRemoveFromFavoritesButton.setTitle("Add To Favorites", for: .normal)
        }
    }

    @IBAction func addOrRemoveFromFavoritedButtonTapped() {
        if isFavorite {
            favoriteBooks = favoriteBooks.filter({$0.volumeId != book.volumeId})
            addOrRemoveFromFavoritesButton.setTitle("Add To Favorites", for: .normal)
        }
        else {
            favoriteBooks.append(book)
            addOrRemoveFromFavoritesButton.setTitle("Remove From Favorites", for: .normal)
        }
    }
    
}
