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
        
        let booksAPI = BooksAPI()
        let task = BackendService.shared.createTask(api: booksAPI) { data, _, error in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    let data = try BooksAPI.mapData(data: data)
                    print(data)
                } catch(let e) {
                    print(e)
                }
            }
        }
        
        task.resume()
    }

}

