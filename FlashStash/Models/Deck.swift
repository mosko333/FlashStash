//
//  Deck.swift
//  FlashStash
//
//  Created by Adam on 24/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

extension Deck {
    convenience init(folder: Folder, name: String, timestamp: Date = Date(), numberOfCards: Int = 0, context: NSManagedObjectContext = CoreDataStack.context) {
        
        // initalizing the context for us to place our data into
        self.init(context: context)
        self.folder = folder
        self.name = name
        self.timestamp = timestamp
        self.numberOfCards = Int64(numberOfCards)
    }
}
