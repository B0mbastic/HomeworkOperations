//
//  ViewController.swift
//  HomeworkOperations
//
//  Created by Александр Ковбасин on 18.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var imageData: Data?
    var imageDataArray: [Data] = []
    
    let url1 = "https://multifoto.ru/upload/medialibrary/b42/b421764c709bae30146ec4c2e9039ec6.png"
    let url2 = "https://www.rgo.ru/sites/default/files/styles/head_image_article/public/node/49533/2131465.jpg?itok=kvFLhXla"
    let url3 = "https://prophotos.ru/data/articles/0002/2622/image-rectangle_600_x.jpg"
    
    private lazy var locationsTable: UITableView = {
        
        let table = UITableView(frame: view.bounds, style: .plain)
        table.register(TableCell.self, forCellReuseIdentifier: identifier)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 200
        return table
    }()
    
    let identifier = "cellID"
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(locationsTable)
        locationsTable.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let firstOperation = DownloadOperation(urlPath: url1)
        firstOperation.completionBlock = {
            DispatchQueue.main.async {
                if let data = firstOperation.imageData{
                    self.imageDataArray.append(data)
                }
            }
        }
        let secondOperation = DownloadOperation(urlPath: url2)
        secondOperation.completionBlock = {
            DispatchQueue.main.async {
                if let data = secondOperation.imageData{
                    self.imageDataArray.append(data)
                }
            }
        }
        let thirdOperation = DownloadOperation(urlPath: url3)
        thirdOperation.completionBlock = {
            DispatchQueue.main.async {
                if let data = thirdOperation.imageData{
                    self.imageDataArray.append(data)
                }
            }
        }
        
        // Управление очередностью операций
        thirdOperation.queuePriority = .high
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperations([firstOperation,secondOperation,thirdOperation], waitUntilFinished: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! TableCell
        DispatchQueue.main.async {
            cell.cellImageView.image = UIImage(data: (self.imageDataArray[indexPath.row]))
        }
        return cell
    }
}

