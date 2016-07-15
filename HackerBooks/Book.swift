//
//  Book.swift
//  HackerBooks
//
//  Created by CLAG on 29/6/16.
//  Copyright © 2016 Clag. All rights reserved.
//

import UIKit

class Book : Equatable {
    
    let title   : String
    let authors : [String]
    var tags    : [String]
    let image   : NSData
    let pdf     : NSData
    
    init(title : String, authors : [String], tags : [String], image : NSData, pdf : NSData) {
        self.title   = title
        self.authors = authors
        self.tags    = tags
        self.image   = image
        self.pdf     = pdf
    }
}

func ==(lhs: Book, rhs: Book) -> Bool {
    return lhs.title.lowercaseString == rhs.title.lowercaseString
}


