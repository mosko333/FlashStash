//
//  DeckListTableViewController.swift
//  FlashStash
//
//  Created by Adam on 28/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class DeckListTableViewController: UITableViewController {
    
    var folder: Folder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = folder?.name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        presentDeckNamingAlertController(deck: nil)
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return folder?.decks?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath) as? DeckTableViewCell {
            let deck = folder?.decks?[indexPath.row] as? Deck
            cell.titleLabel.text = deck?.name
            if let time = deck?.timestamp,
                let numberOfCards = deck?.cards?.count {
                let date = DateFormatter.localizedString(from: time, dateStyle: .short, timeStyle: .short)
                cell.createdDateLabel.text = "Created: \(date)"
                cell.numberOfCardsLabel.text = "\(numberOfCards)"
            }
            return cell
        }
        
        // Configure the cell...
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.presentDeckDeleteAlertController(indexPath: indexPath)
        }
        deleteAction.backgroundColor = .red
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            guard let folder = self.folder,
                let deck = folder.decks?[indexPath.row] as? Deck else { return }
            self.presentDeckNamingAlertController(deck: deck)
        }
        editAction.backgroundColor = .blue
        
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCardList" {
            if let destinationVC = segue.destination as? CardListViewController,
                let indexPath = self.tableView.indexPathForSelectedRow,
                let decks = folder?.decks {
                let deck = decks[indexPath.row] as? Deck
                destinationVC.deck = deck
            }
        }
    }
}

// MARK: - Create and Present AlertController
extension DeckListTableViewController {
    func presentDeckNamingAlertController(deck: Deck?) {
        // 0.5 - Create a optional textfield variable
        var deckNameTextField: UITextField?
        // 1 - Initialize the actual alert controller
        let alertController = UIAlertController(title: "Enter Deck Name", message: "", preferredStyle: .alert)
        // 2 - Add textField to alertController
        alertController.addTextField { (textField) in
            // 2.5 - Set textField we got back from alert to textField we created
            deckNameTextField = textField
        }
        // 3 - Add Actions
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            // AKA What happens when we press the add button VVVVVVV
            guard let deckName = deckNameTextField?.text,
                !deckName.isEmpty,
                let folder = self.folder else { return }
            if let deck = deck {
                DeckController.update(deck: deck, newName: deckName)
            } else {
                DeckController.createDeckWith(name: deckName, to: folder)
            }
            self.tableView.reloadData()
            //            self.tableView.reloadData()
            // AKA What happens when we press the add button ^^^^^^^
        }
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // 4 - Add actions to alert controller
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        // 5 - Present Alert Controller
        present(alertController, animated: true)
    }
    
    func presentDeckDeleteAlertController(indexPath: IndexPath) {

        let alertController = UIAlertController(title: "Are You Sure You Want To Delete This Deck", message: "", preferredStyle: .alert)
        
        // 3 - Add Actions
        let addAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            // AKA What happens when we press the add button
            guard let folder = self.folder,
                let deck = folder.decks?[indexPath.row] as? Deck else { return }
            DeckController.delete(deck: deck, fromA: folder)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // 4 - Add actions to alert controller
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        // 5 - Present Alert Controller
        present(alertController, animated: true)
    }
}
