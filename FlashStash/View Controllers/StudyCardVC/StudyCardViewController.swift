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
    var card: Card?
    let tempCardController = TempCardController(side: .front)
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var cardSideLabel: UILabel!
    @IBOutlet weak var correctBtn: UIButton!
    @IBOutlet weak var incorrectBtn: UIButton!
    // Container Views
    @IBOutlet weak var oneSectionContainerView: OneSectionStudyCardContainerViewController!
    @IBOutlet weak var twoSectionContainerView: TwoSectionStudyCardContainerViewController!
    @IBOutlet weak var resultsContainerView: StudyCardResultsViewController!
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
        
    }
    //
    // MARK: - Actions
    //
    @IBOutlet weak var correctBtnTapped: UIButton!
    @IBOutlet weak var incorrectBtnTapped: UIButton!
}
