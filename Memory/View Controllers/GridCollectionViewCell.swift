//
//  GridCollectionViewCell.swift
//  Memory
//
//  Created by Serena Roderick on 9/5/24.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let size = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: CGFloat(size)),
            self.widthAnchor.constraint(equalToConstant: CGFloat(size)),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
