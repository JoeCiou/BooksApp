//
//  Common.swift
//  Books
//
//  Created by Joe Ciou on 2021/6/15.
//

import Foundation

class BackendService {
    static let shared = BackendService(environment: .production)
    
    let environment: BackendEnvironment
    
    init(environment: BackendEnvironment) {
        self.environment = environment
    }
    
    func createTask(api: API, completedHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        let url = URL(string: environment.domain + api.path)!
        var request = URLRequest(url: url)
        request.httpMethod = api.httpMethod.rawValue
        request.allHTTPHeaderFields = api.headers
        request.httpBody = api.body
        
        return URLSession.shared.dataTask(with: request, completionHandler: completedHandler)
    }
}

enum BackendEnvironment {
    case production
    case staging
    
    var domain: String {
        switch self {
        case .production:
            return Constants.Backend.productionDomain
        case .staging:
            return Constants.Backend.stagingDomain
        }
    }
}

protocol API {
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}


