//
//  Service.swift
//  Books
//
//  Created by Joe Ciou on 2021/6/15.
//

import Foundation

protocol EndPoint {
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

class BackendService: NSObject {
    static let shared = BackendService()
    
    let domain: String = Bundle.main.infoDictionary!["backend_url"] as! String
    
    private let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        // Improve devices are disconnected temporarily from the  internet
        // configuration.waitsForConnectivity = true
        // configuration.timeoutIntervalForRequest =
        
        // Limit the networing access by
        // configuration.allowsCellularAccess
        // configuration.allowsExpensiveNetworkAccess
        // configuration.allowsConstrainedNetworkAccess
        
        // For downloading task in background
        // configuration.sessionSendsLaunchEvents = true
            // For time-insensitive tasks
            // configuration.isDiscretionary = true
        
        return configuration
    }()
    
    private lazy var session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    
    func createTask(api: EndPoint, completedHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let url = URL(string: domain + api.path)!
        var request = URLRequest(url: url)
        request.httpMethod = api.httpMethod.rawValue
        request.allHTTPHeaderFields = api.headers
        request.httpBody = api.body
        
        return session.dataTask(with: request, completionHandler: completedHandler)
    }
}

extension BackendService: URLSessionDataDelegate {
    
}


