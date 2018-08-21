//
//  HomeViewController.swift
//  FlashStash
//
//  Created by Adam on 27/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    //
    // MARK: - Properties
    //
    var folder = FolderController.shared.folders[0]
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var folderCollectionView: UICollectionView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupCollectionView()
    }
    //
    // MARK: - Actions
    //
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        //let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "Create A New Stash", style: .default, handler: { (action:UIAlertAction) in
            self.presentFolderNamingAlertController(cell: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Create A New Deck", style: .default, handler: { (action:UIAlertAction) in
            self.performSegue(withIdentifier: "addDeck", sender: self)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    //
    // MARK: - Navigation
    //
    @IBAction func unwindHomeVC(segue:UIStoryboardSegue) { }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDeckList" {
            if let destinationVC = segue.destination as? DeckListTableViewController {
                destinationVC.folder = folder
            }
        }
    }
}
//
// MARK: - Extensions
//
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        folderCollectionView.delegate = self
        folderCollectionView.dataSource = self
        folderCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3 * 24) / 2
        return CGSize(width: width, height: width * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FolderController.shared.folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {        
        let cell = folderCollectionView.dequeueReusableCell(withReuseIdentifier: "folderCell", for: indexPath) as! FolderCollectionViewCell
        cell.folderNameLabel.text = FolderController.shared.folders[indexPath.row].name
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        folder = FolderController.shared.folders[indexPath.row]
        performSegue(withIdentifier: "toDeckList", sender: indexPath)
    }
    
    func findFolderForCell(cell: FolderCollectionViewCell) -> Folder {
        guard let indexPath = self.folderCollectionView.indexPath(for: cell) else { return Folder()}
        return FolderController.shared.folders[indexPath.row]
    }
}

// MARK: - Create and Present AlertController
extension HomeViewController {
    func presentFolderNamingAlertController(cell: FolderCollectionViewCell?) {
        // 0.5 - Create a optional textfield variable
        var folderNameTextField: UITextField?
        // 1 - Initialize the actual alert controller
        let alertController = UIAlertController(title: "Enter Stash Name", message: "", preferredStyle: .alert)
        // 2 - Add textField to alertController
        alertController.addTextField { (textField) in
            // 2.5 - Set textField we got back from alert to textField we created
            folderNameTextField = textField
        }
        // 3 - Add Actions
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            // AKA What happens when we press the add button VVVVVVV
            guard let folderName = folderNameTextField?.text,
            !folderName.isEmpty else { return }
            if let cell = cell {
                let folder = self.findFolderForCell(cell: cell)
                FolderController.shared.update(folder: folder, newName: folderName)
            } else {
            FolderController.shared.create(folderName: folderName)
            }
            self.folderCollectionView.reloadData()
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

extension HomeViewController: DeckCreatedInNewFolderDelegate {
    func deckCreatedWith(folder: Folder) {
    }
}

extension HomeViewController: FolderCellEditDelegate {
    func selectedFolder(cell: FolderCollectionViewCell) {
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "Rename Your Stash", style: .default, handler: { (action:UIAlertAction) in
            self.presentFolderNamingAlertController(cell: cell)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Delete Your Stash", style: .destructive, handler: { (action:UIAlertAction) in
                let folder = self.findFolderForCell(cell: cell)
                FolderController.shared.delete(folder: folder)
                self.folderCollectionView.reloadData()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
}



















