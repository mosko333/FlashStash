//
//  StudyCardResultsViewController.swift
//  FlashStash
//
//  Created by Adam on 18/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class StudyCardResultsViewController: UIViewController {
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var numberOfCorrectCardsLabel: UILabel!
    @IBOutlet weak var numberOfIncorrectCardsLabel: UILabel!
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
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateScore), name: .sendCardMedia, object: nil)
    }
    @objc func updateScore(notification: Notification) {
        guard let score = notification.object as? Dictionary<String, Int>,
        let correctNumber = score["correct"],
        let incorrectNumber = score["incorrect"] else { return }
        numberOfCorrectCardsLabel.text = "\(correctNumber)"
        numberOfIncorrectCardsLabel.text = "\(incorrectNumber)"
    }
}
