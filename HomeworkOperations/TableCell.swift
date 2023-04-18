//
//  TableCell.swift
//  HomeworkOperations
//
//  Created by Александр Ковбасин on 18.04.2023.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "123"
        return label
    }()
    lazy var cellImageView: UIImageView = {
        let image = UIImageView()
        addSubview(image)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellImageView)
        cellImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

