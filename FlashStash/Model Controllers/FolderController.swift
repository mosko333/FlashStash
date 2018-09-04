//
//  FolderController.swift
//  FlashStash
//
//  Created by Adam on 25/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//


import Foundation
import CoreData

class FolderController {
    
    // steps to think of when making model controller
    // 1) CRUD
    // 2) SOURCE OF TRUTH
    // 3) SharedInstance
    
    // this is our shared instance to get everything inside this class
    static let shared = FolderController()
    
    /// This is our source of TRUTH!!!
    var folders: [Folder] {
        
        // we define out request of what we would like to get back. then we tell it to perform that request
        let request: NSFetchRequest<Folder> = Folder.fetchRequest()
        // WE ALLWAYS NEED TO talk to our context first, in order to get what object we want out of it
        guard let folderArray = try? CoreDataStack.context.fetch(request) else {
            print("❌ Error fetching folders from core data"); return [] }
        if folderArray.count == 0 {
            print("Creating initial folder")
            create(folderName: "General")
            return (try? CoreDataStack.context.fetch(request)) ?? []
        }
        return folderArray
    }
//    
//    init() {
//    }
    
    //C
    func create(folderName: String) {
        // 1) create an instance "Think initalizer"
        Folder(name: folderName)
        CoreDataStack.save()
    }
    
    //R
    
    //U
    func update(folder: Folder, newName: String) {
        folder.name = newName
        CoreDataStack.save()
    }
    
    //D
    func delete(folder: Folder) {
        CoreDataStack.context.delete(folder)
        CoreDataStack.save()
    }
}
