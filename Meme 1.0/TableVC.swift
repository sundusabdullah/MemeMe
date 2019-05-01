//
//  TableVC.swift
//  Meme 1.0
//
//  Created by sundus on 08/08/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//

import UIKit

class TableVC: UITableViewCell {
    
    @IBOutlet weak var TextView: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    func setupMemeView(meme: Memestruct) {
        self.ImageView.image = meme.combiningImage
        self.TextView.text = meme.topText + " " + meme.bottomText
    }
}
