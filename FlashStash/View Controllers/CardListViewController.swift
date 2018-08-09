//
//  CardListViewController.swift
//  FlashStash
//
//  Created by Adam on 31/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController {
    
    var deck: Deck?
    
    @IBOutlet weak var emptyDeckLabel: UILabel!
    @IBOutlet weak var cardListCollectionView: UICollectionView!
    @IBOutlet weak var studyBtnOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.title = deck?.name
        if let deck = deck,
            let cards = deck.cards,
            cards.count > 0 {
            emptyDeckLabel.isHidden = true
            studyBtnOutlet.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.8078431373, blue: 0.4, alpha: 1)
            studyBtnOutlet.isEnabled = true
        } else {
            emptyDeckLabel.isHidden = false
            studyBtnOutlet.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.9529411765, blue: 0.8431372549, alpha: 1)
            studyBtnOutlet.isEnabled = false
        }
    }
    
    
    @IBAction func studyBtnPressed(_ sender: UIButton) {
    }
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
    }
}

extension CardListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        cardListCollectionView.delegate = self
        cardListCollectionView.dataSource = self
        
        let layout = self.cardListCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: (self.cardListCollectionView.frame.size.width / 2) - 20 , height: self.cardListCollectionView.frame.size.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return FolderController.shared.folders.count
        guard let deck = deck,
            let cards = deck.cards else { return 0 }
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cardListCollectionView.dequeueReusableCell(withReuseIdentifier: "cardCVCell", for: indexPath) as! CardListCollectionViewCell
        //        cell.questionTextLabel
        //        cell.folderNameLabel.text = FolderController.shared.folders[indexPath.row].name
        //        cell.delegate = self
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        folder = FolderController.shared.folders[indexPath.row]
    //        performSegue(withIdentifier: "toDeckList", sender: indexPath)
    //    }
    //
    //    func findFolderForCell(cell: FolderCollectionViewCell) -> Folder {
    //        guard let indexPath = self.cardListCollectionView.indexPath(for: cell) else { return Folder()}
    //        return FolderController.shared.folders[indexPath.row]
    //    }
}
