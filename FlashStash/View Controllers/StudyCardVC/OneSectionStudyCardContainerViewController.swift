//
//  OneSectionStudyCardContainerViewController.swift
//  FlashStash
//
//  Created by Adam on 18/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class OneSectionStudyCardContainerViewController: UIViewController, UIGestureRecognizerDelegate {
    //
    // MARK: - Properties
    //
//    lazy var geture = UITapGestureRecognizer(target: self, action: #selector(tapFlip))
    var tempSide = TempSide()
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var cardTextView: UITextView!
    @IBOutlet weak var cardImageView: UIImageView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    //
    // MARK: - Methods
    //
    func setupCard() {
        cardTextView.isHidden = true
        cardTextView.text = ""
        cardImageView.isHidden = true
        cardImageView.image = nil
        if let image = tempSide.top?.image {
            cardImageView.image = image
            cardImageView.isHidden = false
        } else if let text = tempSide.top?.text,
            !text.isEmpty {
            cardTextView.text = text
            cardTextView.isHidden = false
            DispatchQueue.main.async {
                self.cardTextView.centerText()
            }
        }
    }
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(importTempCard), name: .sendCardMedia, object: nil)
    }
    @objc func importTempCard(notification: Notification) {
        guard let tempSide = notification.object as? TempSide else { return }
        self.tempSide = tempSide
        setupCard()
    }
    //
    // MARK: - Actions
    //
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .cardFlipped, object: nil)
    }
    //    @objc func tapFlip() {
//        NotificationCenter.default.post(name: .cardFlipped, object: nil)
//    }
}
