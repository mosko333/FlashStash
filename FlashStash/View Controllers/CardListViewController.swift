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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        } else {
            emptyDeckLabel.isHidden = false
        }
    }
    
    
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
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
