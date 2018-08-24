//
//  StudyCardViewController.swift
//  FlashStash
//
//  Created by Adam on 18/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class StudyCardViewController: UIViewController {
    //
    // MARK: - Properties
    //
    var deck: Deck?
    var cardSide = CardSide.front
    var cardCount = 0
    var score = ["correct":0, "incorrect":0]
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var cardSideLabel: UILabel!
    @IBOutlet weak var correctBtn: UIButton!
    @IBOutlet weak var incorrectBtn: UIButton!
    @IBOutlet weak var wholeCardView: UIView!
    // Container Views
    @IBOutlet weak var oneSectionContainerView: UIView!
    @IBOutlet weak var twoSectionContainerView: UIView!
    @IBOutlet weak var resultsContainerView: UIView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    //
    // MARK: - Methods
    //
    func setupViews() {
        navigationItem.title = deck?.name
        setupNewCard()
    }
    func setupNewCard() {
        guard let cards = deck?.cards else { return }
        if cardCount == cards.count {
            oneSectionContainerView.isHidden = true
            twoSectionContainerView.isHidden = true
            resultsContainerView.isHidden = false
            correctBtn.isEnabled = false
            incorrectBtn.isEnabled = false
            cardSideLabel.text = "Results"
            NotificationCenter.default.post(name: .sendCardMedia, object: score)
        } else {
            guard let card = cards[cardCount] as? Card else {return}
            let tempCard = TempCard(card: card)
            if tempCard.getSide(cardSide).hasTwoSections {
                oneSectionContainerView.isHidden = true
                twoSectionContainerView.isHidden = false
                resultsContainerView.isHidden = true
            } else {
                oneSectionContainerView.isHidden = false
                twoSectionContainerView.isHidden = true
                resultsContainerView.isHidden = true
            }
            NotificationCenter.default.post(name: .sendCardMedia, object: tempCard.getSide(cardSide))
            cardSideLabel.text = cardSide == .front ? "Front" : "Back"
        }
    }
    func flipCard() {
        setupNewCard()
        let transitionOptions = UIViewAnimationOptions.transitionFlipFromLeft
        UIView.transition(with: self.wholeCardView, duration: 0.5, options: transitionOptions, animations: {
            self.cardSide = self.cardSide == .front ? .back : .front
            self.setupNewCard()
        })
    }
    
    func nextCard() {
        cardCount += 1
        cardSide = .front
        let transitionOptions = UIViewAnimationOptions.transitionCurlUp
        UIView.transition(with: self.wholeCardView, duration: 0.5, options: transitionOptions, animations: {
            self.setupNewCard()
        })
    }
    //
    // MARK: - Actions
    //
    @IBAction func tapFlipGesture(_ sender: UITapGestureRecognizer) {
        flipCard()
    }
    @IBAction func correctBtnTapped(_ sender: UIButton) {
        if let correctNumber = score["correct"] {
        score["correct"] = correctNumber + 1
        }
        nextCard()
    }
    @IBAction func incorrectBtnTapped(_ sender: UIButton) {
        if let incorrectNumber = score["incorrect"] {
            score["incorrect"] = incorrectNumber + 1
        }
        nextCard()
    }
}
