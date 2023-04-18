//
//  DownloadOperation.swift
//  HomeworkOperations
//
//  Created by Александр Ковбасин on 18.04.2023.
//

import Foundation

class DownloadOperation : AsyncOperation {
    lazy var urlSession: URLSession = {
        return URLSession(configuration: .default)
    }()
    private var dataTask: URLSessionDataTask? = nil
    private var urlPath: String? = nil
    
    var imageData: Data? = nil
    
    convenience init(urlPath: String) {
        self.init()
        self.urlPath = urlPath
    }
    
    
    override func main() {
        guard let urlPath = URL(string: urlPath!) else {
            state = .finished
            return
        }
        let request = URLRequest(url: urlPath)
        self.dataTask = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }
            self.state = .finished
        })
        self.dataTask?.resume()
    }
}

