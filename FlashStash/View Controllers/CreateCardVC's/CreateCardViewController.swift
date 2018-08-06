//
//  CreateCardViewController.swift
//  FlashStash
//
//  Created by Adam on 01/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class CreateCardViewController: UIViewController {
    
    enum CardSide: String {
        case front = "Front"
        case back = "Back"
    }
    
    enum CardFields {
        case questionTextTop
        case questionTextBottom
        case questionTextWhole
        case questionImageTop
        case questionImageBottom
        case questionImageWhole
        case answerTextTop
        case answerTextBottom
        case answerTextWhole
        case answerImageTop
        case answerImageBottom
        case answerImageWhole
    }
    
    var card: Card?
    var cardSide: CardSide = .front
    
    // Outlets for main controls
    @IBOutlet weak var createCardBackgroundView: UIView!
    @IBOutlet weak var sideOfCardLabel: UILabel!
    @IBOutlet weak var cardBodyImageView: UIImageView!
    @IBOutlet weak var flipBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    // Outlets for ContainerViews
    @IBOutlet weak var oneSectionAddContainerView: UIView!
    @IBOutlet weak var oneSectionShowContainerView: UIView!
    @IBOutlet weak var twoSectionsContainerView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNotificationObservers()
    }
    
    func setupView() {
        createCardBackgroundView.layer.borderColor = #colorLiteral(red: 0.3882352941, green: 0.831372549, blue: 0.4431372549, alpha: 1)
        createCardBackgroundView.layer.borderWidth = 4
        createCardBackgroundView.layer.cornerRadius = 10
        setupBtn()
    }
    
    func setupBtn() {
        if card == nil {
            flipBtn.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
            flipBtn.isEnabled = false
            doneBtn.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
            doneBtn.isEnabled = false
        } else {
            flipBtn.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.8078431373, blue: 0.4, alpha: 1)
            flipBtn.isEnabled = true
            doneBtn.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.8078431373, blue: 0.4, alpha: 1)
            doneBtn.isEnabled = true
        }
    }
    
    // ContainerView funcs for creating cards
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(topImageBtnTapped), name: .topImageBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(topTextBtnTapped), name: .topTextBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addFieldBtnTapped), name: .addFieldBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(bottomImageBtnTapped), name: .bottomImageBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(bottomTextBtnTapped), name: .bottomTextBtnTapped, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteBottomSection), name: .deleteBottomSection, object: nil)
    }
    
    @objc func topImageBtnTapped() {
        oneSectionShowContainerView.isHidden = false
//        oneSectionShowContainerView
        oneSectionAddContainerView.isHidden = true
    }
    @objc func topTextBtnTapped() {
        oneSectionShowContainerView.isHidden = false
        oneSectionAddContainerView.isHidden = true
    }
    @objc func addFieldBtnTapped() {
        twoSectionsContainerView.isHidden = false
        oneSectionShowContainerView.isHidden = true
    }
    @objc func bottomImageBtnTapped() {
    }
    @objc func bottomTextBtnTapped() {
    }
    @objc func deleteBottomSection() {
    }
    

    @IBAction func flipBtnTapped(_ sender: UIButton) {
    }
    @IBAction func doneBtnTapped(_ sender: UIButton) {
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
