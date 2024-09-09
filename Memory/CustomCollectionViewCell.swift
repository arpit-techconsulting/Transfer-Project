//
//  CustomCollectionViewCell.swift
//  Memory
//
//  Created by Arpit Mallick on 9/8/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor),
            imgView.leftAnchor.constraint(equalTo: leftAnchor),
            imgView.rightAnchor.constraint(equalTo: rightAnchor),
            imgView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
