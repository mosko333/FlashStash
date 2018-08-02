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
    @IBOutlet weak var sideOfCardLabel: UILabel!
    @IBOutlet weak var cardBodyImageView: UIImageView!
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var flipBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    // Outlets for OneSectionAdd
    @IBOutlet weak var oneSectionAddContainerView: UIView!
    
    // Outlets for OneSetionShow
    @IBOutlet weak var oneSectionShowContainerView: UIView!
    
    // Outlet for TwoSections
    @IBOutlet weak var twoSectionsContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        cardBackgroundView.layer.borderColor = #colorLiteral(red: 0.3882352941, green: 0.831372549, blue: 0.4431372549, alpha: 1)
        cardBackgroundView.layer.borderWidth = 4
        cardBackgroundView.layer.cornerRadius = 10
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

    @IBAction func flipBtnTapped(_ sender: UIButton) {
    }
    @IBAction func doneBtnTapped(_ sender: UIButton) {
    }
    @IBAction func addFieldBtnTapped(_ sender: UIButton) {
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
