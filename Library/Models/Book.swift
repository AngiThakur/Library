//
//  Book.swift
//  Library
//
//  Created by Thakur, Angita on 5/1/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import SwiftyJSON
import Foundation

struct Book {

    let volumeId: String
    let title: String
    let authors: [String]
    let description: String
    let categories: [String]
    let smallThumbnail: URL?
    let thumbnail: URL?

    init(json: JSON) {
        volumeId = json["id"].stringValue
        title = json["volumeInfo"]["title"].stringValue
        authors = json["volumeInfo"]["authors"].arrayObject as? [String] ?? [String]()
        description = json["volumeInfo"]["description"].stringValue
        categories = json["volumeInfo"]["categories"].arrayObject as? [String] ?? [String]()
        smallThumbnail = json["volumeInfo"]["imageLinks"]["smallThumbnail"].url
        thumbnail = json["volumeInfo"]["imageLinks"]["thumbnail"].url
    }

    var formattedAuthorsString: String {
        guard authors.count > 0 else {
            return ""
        }
        return "By: " + authors.joined(separator: ", ")
    }

    var formattedCategoriesString: String {
        guard categories.count > 0 else {
            return ""
        }
        return "Categories: " + categories.joined(separator: ", ")
    }

}
