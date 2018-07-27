//
//  CardController.swift
//  FlashStash
//
//  Created by Adam on 25/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CoreData

class CardController {
    
    // This is a static method that belongs to the class so we do not need an instance
    static func createCardWith(answerImage: NSObject, answerText: String, correctAnswer: Bool, questionImage: NSObject, questionText: String, to deck: Deck) {
        
        let _ = Card(deck: deck, answerImage: answerImage, answerText: answerText, correctAnswer: correctAnswer, questionImage: questionImage, questionText: questionText)
        CoreDataStack.save()
    }
    
    static func delete(card: Card, fromA deck: Deck) {
        CoreDataStack.context.delete(card)
        CoreDataStack.save()
    }
}
