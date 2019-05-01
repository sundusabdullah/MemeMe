//
//  ShowImage.swift
//  Meme 1.0
//
//  Created by sundus on 08/08/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//

import UIKit

class ShowImage: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbText: UILabel!
    
    var meme: Memestruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meMe = self.meme {
            self.imageView.image = meMe.combiningImage
            self.lbText.text = meMe.topText + " " + meMe.bottomText
        }
    }
    
    @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    
    
    
    
    
}
