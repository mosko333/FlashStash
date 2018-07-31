//
//  HomeViewController.swift
//  FlashStash
//
//  Created by Adam on 27/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var folderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        //        let addDeckViewController = self.childViewControllers[0] as? AddDeckViewController
        //        addDeckViewController?.delegate = self
    }
    
    
    
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        //let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "Create A New Stash", style: .default, handler: { (action:UIAlertAction) in
            self.presentFolderNamingAlertController()
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Create A New Deck", style: .default, handler: { (action:UIAlertAction) in
            self.performSegue(withIdentifier: "addDeck", sender: self)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    // MARK: - Navigation
    
    @IBAction func unwindHomeVC(segue:UIStoryboardSegue) { }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDeckList" {
            if let destinationVC = segue.destination as? DeckListTableViewController,
                let indexPath = sender as? IndexPath {
                let folder = FolderController.shared.folders[indexPath.row]
                destinationVC.folder = folder
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setupCollectionView() {
        folderCollectionView.delegate = self
        folderCollectionView.dataSource = self
        
        let layout = self.folderCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (self.folderCollectionView.frame.size.width / 2) - 26 , height: self.folderCollectionView.frame.size.height/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return FolderController.shared.folders.count
        return FolderController.shared.folders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = folderCollectionView.dequeueReusableCell(withReuseIdentifier: "folderCell", for: indexPath) as! FolderCollectionViewCell
        cell.folderNameLabel.text = FolderController.shared.folders[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDeckList", sender: indexPath)
    }
}

// MARK: - Create and Present AlertController
extension HomeViewController {
    func presentFolderNamingAlertController() {
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
            guard let folderName = folderNameTextField?.text else { return }
            FolderController.shared.create(folderName: folderName)
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
