//
//  CreateCardViewController.swift
//  FlashStash
//
//  Created by Adam on 01/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class CreateCardViewController: UIViewController {
    
    var deck: Deck?
    var card: Card?
    let tempCardController = TempCardController(side: .front)

    
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
        setupView()
        setupNotificationObservers()
        
        //NotificationCenter.default.post(name: .addFieldBtnTapped, object: "ADam and Jayden <3")

    }
    
    func setupView() {
        createCardBackgroundView.layer.borderColor = #colorLiteral(red: 0.3882352941, green: 0.831372549, blue: 0.4431372549, alpha: 1)
        createCardBackgroundView.layer.borderWidth = 4
        createCardBackgroundView.layer.cornerRadius = 10
        setupBtn(cardSideFilled: false, bothCardSidesFilled: false)
    }
    
    
    
    func setupBtn(cardSideFilled: Bool, bothCardSidesFilled: Bool) {
        if cardSideFilled {
            flipBtn.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.8078431373, blue: 0.4, alpha: 1)
            flipBtn.isEnabled = true
            if bothCardSidesFilled {
                doneBtn.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.8078431373, blue: 0.4, alpha: 1)
                doneBtn.isEnabled = true
            } else {
                doneBtn.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
                doneBtn.isEnabled = false
            }
        } else {
            flipBtn.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
            flipBtn.isEnabled = false
            doneBtn.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
            doneBtn.isEnabled = false
        }
    }
    
    // ContainerView funcs for creating cards
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(topImageBtnTapped), name: .topImageBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(topTextBtnTapped), name: .topTextBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteTopSectionBtnTapped), name: .deleteTopSectionBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addFieldBtnTapped), name: .addFieldBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(bottomImageBtnTapped), name: .bottomImageBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(bottomTextBtnTapped), name: .bottomTextBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cardTopSectionFilled), name: .cardTopSectionFilled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cardBottomSectionFilled), name: .cardBottomSectionFilled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteBottomSectionBtnTapped), name: .deleteBottomSectionBtnTapped, object: nil)
        
        
        // DELETE
    }
    
    @objc func topImageBtnTapped() {
    }
    @objc func topTextBtnTapped(notification: Notification) {
    }
    @objc func addFieldBtnTapped(notification: Notification) {
        twoSectionsContainerView.isHidden = false
        oneSectionShowContainerView.isHidden = true
//        guard let myString = notification.object as? String else { return }
//        print(myString)
    }
    @objc func deleteTopSectionBtnTapped() {

    }
    @objc func bottomImageBtnTapped() {
    }
    @objc func bottomTextBtnTapped() {
    }
    @objc func cardTopSectionFilled(notification: Notification) {
        if let media = notification.object {
            tempCardController.addMedia(position: .top, media: media)
        }
    }
    @objc func cardBottomSectionFilled(notification: Notification) {
        if let media = notification.object {
            tempCardController.addMedia(position: .bottom, media: media)
        }
    }
    @objc func deleteBottomSectionBtnTapped() {
        tempCardController.deleteContentPosition(position: .bottom)
    }
    

    @IBAction func flipBtnTapped(_ sender: UIButton) {
        tempCardController.side = tempCardController.side == .front ? .back : .front
        NotificationCenter.default.post(name: .cardFlipped, object: nil)
    }
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        guard let deck = deck else { return }
        tempCardController.saveCardIntoCoreData(deck: deck)
        dismiss(animated: true)
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
