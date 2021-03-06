//
//  CreateCardViewController.swift
//  FlashStash
//
//  Created by Adam on 01/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

protocol CreateCardViewControllerDelegate: class {
    func appendedDeck(deck: Deck)
}

class CreateCardViewController: UIViewController {
    
    var deck: Deck?
    var card: Card?
    let tempCardController = TempCardController(side: .front)
    weak var delegate: CreateCardViewControllerDelegate?
    
    
    // Outlets for main controls
    @IBOutlet weak var createCardBackgroundView: UIView!
    @IBOutlet weak var sideOfCardLabel: UILabel!
    @IBOutlet weak var cardBodyImageView: UIImageView!
    @IBOutlet weak var flipBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    // Outlets for ContainerViews
    @IBOutlet weak var oneSectionShowContainerView: UIView!
    @IBOutlet weak var twoSectionsContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObservers()
        setupView()
    }
    
    func setupView() {
        createCardBackgroundView.layer.borderColor = #colorLiteral(red: 0.3882352941, green: 0.831372549, blue: 0.4431372549, alpha: 1)
        createCardBackgroundView.layer.borderWidth = 4
        createCardBackgroundView.layer.cornerRadius = 10
        if let card = card {
            let sentTempCard = TempCard(card: card)
            tempCardController.tempCard = sentTempCard
        }
        setupCardSide()
    }
    
    
    
    func setupBtn() {
        if tempCardController.tempCard.front.isBlank == false || tempCardController.tempCard.back.isBlank == false {
            flipBtn.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.8078431373, blue: 0.4, alpha: 1)
            flipBtn.isEnabled = true
        } else {
            flipBtn.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
            flipBtn.isEnabled = false
        }
        if tempCardController.tempCard.isComplete {
            doneBtn.backgroundColor = #colorLiteral(red: 0.3058823529, green: 0.7803921569, blue: 0.3568627451, alpha: 1)
            doneBtn.isEnabled = true
        } else {
            doneBtn.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
            doneBtn.isEnabled = false
        }
    }
    
    func setupCardSide() {
        if tempCardController.tempCard.getSide(tempCardController.side).hasTwoSections {
            twoSectionsContainerView.isHidden = false
            oneSectionShowContainerView.isHidden = true
        } else {
            oneSectionShowContainerView.isHidden = false
            twoSectionsContainerView.isHidden = true
        }
        NotificationCenter.default.post(name: .sendCardMedia, object: tempCardController.tempCard.getSide(tempCardController.side))
        setupBtn()
    }
    
    // ContainerView funcs for creating cards
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(deleteTopSectionBtnTapped), name: .deleteTopSectionBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addFieldBtnTapped), name: .addFieldBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cardTopSectionFilled), name: .cardTopSectionFilled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cardBottomSectionFilled), name: .cardBottomSectionFilled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteBottomSectionBtnTapped), name: .deleteBottomSectionBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(segueToOnlineImageSearch), name: .segueToOnlineImageSearch, object: nil)
        
        // DELETE
    }
    
    @objc func addFieldBtnTapped(notification: Notification) {
        twoSectionsContainerView.isHidden = false
        oneSectionShowContainerView.isHidden = true
    }
    @objc func deleteTopSectionBtnTapped() {
        tempCardController.deleteMedia(position: .top)
        setupBtn()
    }
    @objc func cardTopSectionFilled(notification: Notification) {
        if let media = notification.object {
            tempCardController.addMedia(position: .top, media: media)
        } else {
            tempCardController.deleteMedia(position: .top)
        }
        setupBtn()
    }
    @objc func cardBottomSectionFilled(notification: Notification) {
        if let media = notification.object {
            tempCardController.addMedia(position: .bottom, media: media)
        }else {
            tempCardController.deleteMedia(position: .top)
        }
        setupBtn()
    }
    @objc func deleteBottomSectionBtnTapped() {
        tempCardController.deleteContentPosition(position: .bottom)
    }
    @objc func segueToOnlineImageSearch() {
        performSegue(withIdentifier: "fromSecOneToWebImageSearchVC", sender: self)
    }
    
    
    @IBAction func flipBtnTapped(_ sender: UIButton) {
        if tempCardController.side == .front {
            tempCardController.side = .back
            sideOfCardLabel.text = "Back"
        } else {
            tempCardController.side = .front
            sideOfCardLabel.text = "Front"
        }
        setupCardSide()
    }
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        guard let deck = deck else { return }
        if card == nil {
            tempCardController.saveCardIntoCoreData(deck: deck)
        } else {
            self.card?.questionText = tempCardController.tempCard.front.top?.text
        }
        delegate?.appendedDeck(deck: deck)
        navigationController?.popViewController(animated: true)
    }
}



















