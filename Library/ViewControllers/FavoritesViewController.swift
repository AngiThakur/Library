//
//  FavoritesViewController.swift
//  Library
//
//  Created by Thakur, Angita (ETW) on 5/3/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseBooksTableViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.books = (UIApplication.shared.delegate as! AppDelegate).favoriteBooks
        self.booksTableView.reloadData()
    }
    
}
