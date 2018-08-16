//
//  OneSectionShowContainerViewController.swift
//  FlashStash
//
//  Created by Adam on 01/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class OneSectionShowContainerViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
//    var tempCard: TempCard?
//    var cardSide: CardSide = .front
//    var cardField: CardField {
//        //let state = cardSide == .front ? CardField.topQuestion : CardField.topAnswer
//    return state }

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardTextView: UITextView!
    @IBOutlet weak var deleteFieldUIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTextView.delegate = self
    }
    
    func addObservers() {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        cardTextView.frame.size.height -= 100
    }
    func textViewDidEndEditing(_ textView: UITextView) {

//        tempCard?.getSide(.front).top.text = cardTextView.text.isEmpty ? nil : cardTextView.text
//        NotificationCenter.default.post(name: .cardSideFilled, object: tempCard)
        
        if let text = cardTextView.text,
            !text.isEmpty {
            NotificationCenter.default.post(name: .cardTopSectionFilled, object: text)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.5) {
                self.cardTextView.centerText()
            }
        }
    }
    
    @IBAction func deleteFieldBtnTapped(_ sender: UIButton) {
        cardTextView.isHidden = true
        cardImageView.isHidden = true
        cardImageView.image = nil
        deleteFieldUIButton.isHidden = true
        NotificationCenter.default.post(name: .deleteTopSectionBtnTapped, object: nil)
    }
    
    @IBAction func addImageBtnTapped(_ sender: UIButton) {
        cardTextView.isHidden = true
        cardImageView.isHidden = false
        deleteFieldUIButton.isHidden = false
        showPictureInputActionSheet()
        NotificationCenter.default.post(name: .topImageBtnTapped, object: nil)
    }
    
    @IBAction func addTextBtnTapped(_ sender: UIButton) {
        cardTextView.isHidden = false
        cardTextView.centerText()
        cardImageView.isHidden = true
        deleteFieldUIButton.isHidden = false
        NotificationCenter.default.post(name: .topTextBtnTapped, object: nil)

    }
    
    @IBAction func addFieldBtnTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .addFieldBtnTapped, object: nil)
    }
}

extension OneSectionShowContainerViewController {
    
    func showPictureInputActionSheet() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose A Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true)
            } else {
                print("Camera not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Scan", style: .default, handler: { (action:UIAlertAction) in

        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage

        //guard let word = word else { return }
        //WordController.addImage(with: image, to: word)
        //wordImage.image = image
        cardImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

















