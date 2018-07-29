//
//  HomeViewController.swift
//  FlashStash
//
//  Created by Adam on 27/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var folderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        //let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "Create A New Stash", style: .default, handler: { (action:UIAlertAction) in
            

        }))
        
        actionSheet.addAction(UIAlertAction(title: "Create A New Deck", style: .default, handler: { (action:UIAlertAction) in

        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        folderCollectionView.delegate = self
        folderCollectionView.dataSource = self
        
        let layout = self.folderCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (self.folderCollectionView.frame.size.width / 2) - 26 , height: self.folderCollectionView.frame.size.height/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return FolderController.shared.folders.count
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = folderCollectionView.dequeueReusableCell(withReuseIdentifier: "folderCell", for: indexPath) as! FolderCollectionViewCell
        cell.folderNameLabel.text = FolderController.shared.folders[0].name
        return cell
        
    }
}
