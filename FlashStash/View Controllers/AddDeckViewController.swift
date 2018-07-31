//
//  AddDeckViewController.swift
//  FlashStash
//
//  Created by Adam on 29/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

protocol DeckCreatedInNewFolderDelegate: class {
    func deckCreatedWith(folder: Folder)
}

class AddDeckViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var folder = FolderController.shared.folders[0]
    weak var delegate: DeckCreatedInNewFolderDelegate?
    
    @IBOutlet weak var deckNameTextField: UITextField!
    @IBOutlet weak var folderNameTextField: UITextField!
    @IBOutlet weak var folderNamePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folderNamePicker.delegate = self
        folderNamePicker.dataSource = self
        folderNameTextField.inputView = folderNamePicker
        folderNameTextField.text = FolderController.shared.folders[0].name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FolderController.shared.folders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FolderController.shared.folders[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        folderNameTextField.text = FolderController.shared.folders[row].name
    }
    @IBAction func nextBarBtnTapped(_ sender: UIBarButtonItem) {
        guard let deckName = deckNameTextField.text else {return}
        if !deckName.isEmpty {
            DeckController.createDeckWith(name: deckName, to: folder)
            deckNameTextField.text = ""
            performSegue(withIdentifier: "toDeckList", sender: self)
        }
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        guard let deckName = deckNameTextField.text else {return}
        if !deckName.isEmpty {
            DeckController.createDeckWith(name: deckName, to: folder)
            deckNameTextField.text = ""
            performSegue(withIdentifier: "toDeckList", sender: self)
        }
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDeckList" {
            if let destinationVC = segue.destination as? DeckListTableViewController {
                destinationVC.folder = self.folder
            }
        }
     }

    
}
