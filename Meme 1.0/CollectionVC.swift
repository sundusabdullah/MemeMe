//
//  CollectionVC.swift
//  Meme 1.0
//
//  Created by sundus on 07/08/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//

import UIKit

class CollectionVC: UICollectionViewCell {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Text: UILabel!

    
    func setupMemeView(meme: Memestruct) {
        self.ImageView.image = meme.combiningImage
        self.Text.text = meme.topText + " " + meme.bottomText
    }
}
