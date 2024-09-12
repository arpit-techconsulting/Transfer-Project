//
//  GridCollectionViewCell.swift
//  Memory
//
//  Created by Serena Roderick on 9/5/24.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    var backgroundImageAsset = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showImage() {
        self.backgroundColor = .green
//        let uiImageView = UIImageView(image: imgsArr[itemIndex])
//        self.addSubview(uiImageView)
//        uiImageView.translatesAutoresizingMaskIntoConstraints = false
//        uiImageView.frame = self.contentView.bounds
//        self.backgroundColor = nil
    }
}
