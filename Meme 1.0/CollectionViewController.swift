//
//  MemeFlowlayout.swift
//  Meme 1.0
//
//  Created by sundus on 07/08/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowlayout.minimumInteritemSpacing = space
        flowlayout.minimumLineSpacing = space
        flowlayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeDatabase.sheard().dataSources.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionVC
      
        let meme = MemeDatabase.sheard().dataSources[indexPath.row]
        cell.setupMemeView(meme: meme)

        return cell
        
    }

    
   /* override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailVC from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "ShowMeme") as! ShowImage
        
        //Populate view controller with data from the selected item
        detailController.meme = MemeDatabase.sheard().dataSources[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
        
    }*/
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if let nvShow = self.storyboard?.instantiateViewController(withIdentifier: "ShowMeme") as? UINavigationController {
            if let show = nvShow.visibleViewController as? ShowImage {
                collectionView.cellForItem(at: indexPath)
                show.meme = MemeDatabase.sheard().dataSources[indexPath.row]
                self.present(nvShow, animated: true)
            }
        }
    }
    
    
    

    
    
}
    
 

