//
//  ViewController.swift
//  Books
//
//  Created by Joe Ciou on 2021/6/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let booksAPI = BooksEndPoint()
        let task = BackendService.shared.createTask(api: booksAPI) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let httpResponse = response as? HTTPURLResponse,
                  !(200...299).contains(httpResponse.statusCode) {
                print(httpResponse.statusCode)
                return
            }
            if let data = data {
                do {
                    let data = try BooksEndPoint.mapData(data: data)
                    print(data)
                } catch(let e) {
                    print(e)
                }
            }
        }
        
        task.resume()
    }

}

