//
//  FrameworkCollectionViewCell.swift
//  AppleFramework
//
//  Created by Kay on 2022/08/18.
//

import UIKit

class FrameworkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(_ framework: AppleFramework) {
        thumbnailImageView.image = UIImage(named: framework.imageName)
        nameLabel.text = framework.name
    }
}
