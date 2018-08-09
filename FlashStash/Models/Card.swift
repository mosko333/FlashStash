//
//  Card.swift
//  FlashStash
//
//  Created by Adam on 24/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

//enum CardField {
//    case topQuestionText
//    case topQuestionImage
//    case bottomQuestionText
//    case bottomQuestionImage
//    case topAnswerText
//    case topAnswerImage
//    case bottomAnswerText
//    case bottomAnswerImage
//}

extension Card {
    convenience init(deck: Deck, answerImage: Data, answerText: String, correctAnswer: Bool, questionImage: Data, questionText: String, managedObjectContext: NSManagedObjectContext = CoreDataStack.context) {
        // Initialize into the manage object context
        self.init(context: managedObjectContext)
        self.deck = deck
        self.questionImage = questionImage
        self.questionText = questionText
        self.answerImage = answerImage
        self.answerText = answerText
        self.correctAnswer = correctAnswer
    }
    
    convenience init(deck: Deck, tempCard: TempCard, managedObjectContext: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: managedObjectContext)
        self.deck = deck
        self.questionImage = tempCard.front.top?.imageData
        self.questionText = tempCard.front.top?.text
        self.answerImage = tempCard.back.top?.imageData
        self.answerText = tempCard.back.top?.text
    }
}
