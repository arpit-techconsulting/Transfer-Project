//
//  GridCollectionViewCell.swift
//  Memory
//
//  Created by Serena Roderick on 9/5/24.
//

import UIKit
import Combine


class GridCollectionViewCell: UICollectionViewCell {
    let gameVM = GameViewModel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showImage(itemIndex: Int, isPlaying: Bool) {
        if isPlaying {
            let imageView = UIImageView(image: UIImage(named: gameVM.imgNames[itemIndex]))
            self.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.frame = self.contentView.bounds
            GameVC.guessMatch.append(gameVM.imgNames[itemIndex])
        }
    }
    
    func hideImage() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
}
