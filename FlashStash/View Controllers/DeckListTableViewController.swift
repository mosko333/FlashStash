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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        presentDeckNamingAlertController()
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
            //TODO: Delete the row at indexPath here
        }
        deleteAction.backgroundColor = .red
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
        }
        editAction.backgroundColor = .blue
        
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

// MARK: - Create and Present AlertController
extension DeckListTableViewController {
    func presentDeckNamingAlertController() {
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
            DeckController.createDeckWith(name: deckName, to: folder)
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
}
