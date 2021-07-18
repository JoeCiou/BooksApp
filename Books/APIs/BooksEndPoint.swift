//
//  BooksEndPoint.swift
//  Books
//
//  Created by Joe Ciou on 2021/6/15.
//

import Foundation

struct BooksAPIResponse: Decodable {
    let books: [Book]
}

class BooksEndPoint: EndPoint {
    let httpMethod: HTTPMethod = .get
    
    var path: String {
        return "/api/v1/books" // Add parameters
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
    // The initializer can add parameters, addtional headers, and body
    init() {
        
    }
    
    // Map to the specfic response
    static func mapData(data: Data) throws -> BooksAPIResponse {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(BooksAPIResponse.self, from: data)
    }
}
