//
//  GameVm.swift
//  Memory
//
//  Created by Arpit Mallick on 9/11/24.
//

import Foundation
import UIKit

class GameVm {
    var imageNames = ["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h"]
    var shuffledImgNames: [String] = [] // Created an empty array of imageNames
    private var gridData: [IndexPath: (imageName: String, isRevealed: Bool)] = [:]
    private var flippedIndexPaths: [IndexPath] = []
    private var totalPoints = 0
    
    var gameOver: ((Int) -> Void)?
    
    func coreFunc(collectionView: UICollectionView, indexPath: IndexPath) {
        
        if flippedIndexPaths.count == 2 {
            // Flipping the first two back to original state
            for path in flippedIndexPaths {
                if let cell = collectionView.cellForItem(at: path) as? CustomCollectionViewCell {
                    cell.imgView.image = nil
                    cell.backgroundColor = .gray
                    
                    gridData[path]?.isRevealed = false
                }
            }
            // Clearing the flipped cells array when there are 2 elements in the array
            flippedIndexPaths.removeAll()
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
        
        
        // Checking if the image is already avalaible in the gridData dictionary
        if let data = gridData[indexPath] {
            if data.isRevealed {
                return // If already revealed, then doing nothing
            }
            
            cell.imgView.image = UIImage(named: data.imageName)
            cell.backgroundColor = .clear
            gridData[indexPath]?.isRevealed = true
        } else {
            // Assigning a random image (if not revealed) to this cell and making the isRevealed to true
            let randomImageName = shuffledImgNames[indexPath.item]
            gridData[indexPath] = (imageName: randomImageName, isRevealed: true)
            cell.imgView.image = UIImage(named: randomImageName)
            cell.backgroundColor = .clear
        }
        
        print(gridData)
        
        // Adding the current cell to the flipped cells array
        flippedIndexPaths.append(indexPath)
        print(flippedIndexPaths)
        
        if flippedIndexPaths.count == 2 {
            let firstFlippedImgPath = flippedIndexPaths[0]
            let secondFlippedImgPath = flippedIndexPaths[1]
            
            if gridData[firstFlippedImgPath]?.imageName == gridData[secondFlippedImgPath]?.imageName {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if let firstCell = collectionView.cellForItem(at: firstFlippedImgPath) as? CustomCollectionViewCell, let secondCell = collectionView.cellForItem(at: secondFlippedImgPath) as? CustomCollectionViewCell {
                        
                        firstCell.isHidden = true
                        secondCell.isHidden = true
                        
                        self.gridData[firstFlippedImgPath] = nil
                        self.gridData[secondFlippedImgPath] = nil
                        
                        self.totalPoints += 1
                        
                        if self.gridData.isEmpty {
                            self.gameOver?(self.totalPoints)
                        }
                    }
                    
                    self.flippedIndexPaths.removeAll()
                }
            }
            
        }
        
        print(gridData)
        print(flippedIndexPaths)
    }
}
