//
//  DeckController.swift
//  FlashStash
//
//  Created by Adam on 25/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation
import CoreData

class DeckController {
    
    // This is a static method that belongs to the class so we do not need an instance
    static func createDeckWith(name: String, to folder: Folder) {
        let _ = Deck(folder: folder, name: name)
        CoreDataStack.save()
    }
    
    static func update(deck: Deck, newName: String) {
        deck.name = newName
        CoreDataStack.save()
    }
    
    static func delete(deck: Deck, fromA folder: Folder) {
        guard let index = folder.decks?.index(of: deck),
            let deckToDelete = folder.decks?.object(at: index) as? Deck else { return }
        CoreDataStack.context.delete(deckToDelete)
        CoreDataStack.save()
    }
}

