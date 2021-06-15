//
//  Book.swift
//  Books
//
//  Created by Joe Ciou on 2021/6/15.
//

import Foundation

struct Book: Decodable {
    let name: String
    let imageUrl: String
    let description: String
}
