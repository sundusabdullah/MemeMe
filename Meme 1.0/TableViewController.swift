//
//  TableViewController.swift
//  Meme 1.0
//
//  Created by sundus on 08/08/1440 AH.
//  Copyright © 1440 sundus. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeDatabase.sheard().dataSources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCall", for: indexPath) as? TableVC else {
            return UITableViewCell()
        }
        let meme = MemeDatabase.sheard().dataSources[indexPath.row]
        cell.setupMemeView(meme: meme)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nvShow = self.storyboard?.instantiateViewController(withIdentifier: "ShowMeme") as? UINavigationController {
            if let show = nvShow.visibleViewController as? ShowImage {
                tableView.deselectRow(at: indexPath, animated: true)
                show.meme = MemeDatabase.sheard().dataSources[indexPath.row]
                self.present(nvShow, animated: true)
            }
        }
    }

}
    
    
    
    
    

