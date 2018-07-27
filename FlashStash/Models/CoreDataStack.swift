//
//  CoreDataStack.swift
//  FlashStash
//
//  Created by Adam on 25/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//


import Foundation
import CoreData

struct CoreDataStack {
    
    // Declare a variable for our Persistent Container
    static let container: NSPersistentContainer = {
        
        // Grab the app name
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        
        // Create the actual container object
        let container = NSPersistentContainer(name: appName)
        
        // Load data from persistent store
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // Creating a reference to our Managed Object Context (MOC) so that we can access it elsewhere in the project
    static var context: NSManagedObjectContext { return container.viewContext }
    
    /// saveToPersistentStore
    static func save() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("Error saving to persistant data \(#function) \(error) \(error.localizedDescription)")
        }
        
    }
}
