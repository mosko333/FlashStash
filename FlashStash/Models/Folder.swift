//
//  Folder.swift
//  FlashStash
//
//  Created by Adam on 24/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
import CoreData

extension Folder {
    @discardableResult convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        // initalizing the context for us to place our data into
        self.init(context: context)
        self.name = name
    }
}
