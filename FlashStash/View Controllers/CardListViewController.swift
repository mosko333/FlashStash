//
//  CardListViewController.swift
//  FlashStash
//
//  Created by Adam on 31/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController {
    //
    // MARK: - Properties
    //
    var deck: Deck?
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var emptyDeckLabel: UILabel!
    @IBOutlet weak var cardListCollectionView: UICollectionView!
    @IBOutlet weak var studyBtnOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //
    // MARK: - Lifecycle Functions
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupView()
        setupCollectionView()
    }
    //
    // MARK: - Methods
    //
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
    
    //
    // MARK: - Actions
    //
    @IBAction func studyBtnPressed(_ sender: UIButton) {
    }
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
    }
}
//
// MARK: - Extensions
//
extension CardListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        cardListCollectionView.delegate = self
        cardListCollectionView.dataSource = self
        cardListCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let deck = deck,
            let cards = deck.cards else { return 0 }
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cardListCollectionView.dequeueReusableCell(withReuseIdentifier: "cardCVCell", for: indexPath) as! CardListCollectionViewCell
        if let cards = deck?.cards,
            let card = cards[indexPath.row] as? Card {
            if let imageData = card.questionImage {
                cell.questionTextLabel.isHidden = true
                cell.questionImage.image = UIImage(data: imageData)
                cell.questionImage.isHidden = false
            } else if let text = card.questionText,
                text.isEmpty == false {
                cell.questionImage.isHidden = true
                cell.questionTextLabel.text = text
                cell.questionTextLabel.isHidden = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3 * 24) / 2
        return CGSize(width: width, height: width * 1.38)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateCard" {
            if let destinationVC = segue.destination as? CreateCardViewController {
                destinationVC.delegate = self
                destinationVC.deck = deck
            }
        }
        if segue.identifier == "toEditCard" {
            if let destinationVC = segue.destination as? CreateCardViewController,
                let indexPaths = self.cardListCollectionView.indexPathsForSelectedItems,
                let cards = deck?.cards {
                let indexPath = indexPaths[0]
                let card = cards[indexPath.row] as? Card
                destinationVC.deck = deck
                destinationVC.card = card
            }
        }
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

extension CardListViewController: CreateCardViewControllerDelegate {
    func appendedDeck(deck: Deck) {
        self.deck = deck
        cardListCollectionView.reloadData()
    }
}
