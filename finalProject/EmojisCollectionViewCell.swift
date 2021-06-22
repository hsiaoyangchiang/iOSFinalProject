//
//  EmojisCollectionViewCell.swift
//  finalProject
//
//  Created by 江曉陽 on 2021/6/11.
//

import UIKit

class EmojisCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emojiImage: UIImageView!
    
    func setup(with emojis: Emojis) {
         emojiImage.image = emojis.image
    }
}
