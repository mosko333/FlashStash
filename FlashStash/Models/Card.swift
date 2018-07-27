//
//  Card.swift
//  FlashStash
//
//  Created by Adam on 24/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData


extension Card {
    convenience init(deck: Deck, answerImage: Data, answerText: String, correctAnswer: Bool, questionImage: Data, questionText: String, managedObjectContext: NSManagedObjectContext = CoreDataStack.context) {
        // Initialize into the manage object context
        self.init(context: managedObjectContext)
        self.deck = deck
        self.answerImage = answerImage
        self.answerText = answerText
        self.correctAnswer = correctAnswer
        self.questionImage = questionImage
        self.questionText = questionText
    }
}
