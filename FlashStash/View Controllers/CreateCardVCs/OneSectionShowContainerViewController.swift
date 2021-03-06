//
//  OneSectionShowContainerViewController.swift
//  FlashStash
//
//  Created by Adam on 01/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class OneSectionShowContainerViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    struct Constants {
        static var placeholderText = "Please enter your note here:"
    }
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardTextView: UITextView!
    @IBOutlet weak var deleteFieldUIButton: UIButton!
    //
    // MARK: - Properties
    //
    lazy var textViewMargin = cardTextView.frame.size.height / 3
    var text: String?
    var image: UIImage?
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTextView.delegate = self
        addObservers()
        setupCard()
    }
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addMedia), name: .sendCardMedia, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onlineImageSelected), name: .onlineImageSelected, object: nil)
    }
    @objc func onlineImageSelected(notification: Notification) {
        guard let imageUrlString = notification.object as? String else { return }
        OnlineImageController.fetchImageWith(urlString: imageUrlString ) { (image) in
            let fetchedImage = image
            DispatchQueue.main.async {
                self.image = fetchedImage
                self.setupCard()
                NotificationCenter.default.post(name: .cardTopSectionFilled, object: fetchedImage)
            }
        }
    }
    @objc func addMedia(notification: Notification) {
        image = nil
        text = nil
        guard let cardSide = notification.object as? TempSide else { return }
        if let image = cardSide.top?.image {
            self.image = image
        } else if let text = cardSide.top?.text,
            !text.isEmpty {
            self.text = text
        }
        setupCard()
    }

    func setupCard(){
        cardTextView.isHidden = true
        cardImageView.isHidden = true
        deleteFieldUIButton.isHidden = false
        addPlaceholderText()
        cardImageView.image = nil
        if let image = image {
            cardImageView.image = image
            cardImageView.isHidden = false
        } else if let text = text,
            !text.isEmpty {
            cardTextView.textColor = .black
            cardTextView.text = text
            cardTextView.isHidden = false
            DispatchQueue.main.async {
                self.cardTextView.centerText()
            }
        } else {
            deleteFieldUIButton.isHidden = true
        }
    }
    
    func addPlaceholderText() {
        cardTextView.text = Constants.placeholderText
        cardTextView.textColor = .lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Reduces the height of the text field when the keyboard popsup.
        cardTextView.frame.size.height -= textViewMargin
        if cardTextView.text == Constants.placeholderText {
            cardTextView.text = ""
            cardTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let text = cardTextView.text {
            self.text = text.isEmpty || text == Constants.placeholderText ? nil : text
            NotificationCenter.default.post(name: .cardTopSectionFilled, object: self.text)
            setupCard()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.cardTextView.frame.size.height += self.textViewMargin
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
        showPictureInputActionSheet(sender)
    }
    
    @IBAction func addTextBtnTapped(_ sender: UIButton) {
        cardTextView.isHidden = false
        cardTextView.centerText()
        cardImageView.isHidden = true
        deleteFieldUIButton.isHidden = false
    }
    
    @IBAction func addFieldBtnTapped(_ sender: UIButton) {
        var media: Any? = nil
        if let text = text,
            !text.isEmpty {
            media = text
        } else if let image = image {
            media = image
        }
        NotificationCenter.default.post(name: .addFieldBtnTapped, object: media)
    }
}

extension OneSectionShowContainerViewController {
    
    func showPictureInputActionSheet(_ sender: UIButton) {
        
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
        
        actionSheet.addAction(UIAlertAction(title: "Web Search", style: .default, handler: { (action:UIAlertAction) in
            self.performSegue(withIdentifier: "fromSecOneToWebImageSearchVC", sender: self)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // If the device is an ipad, this statement adds the actionSheet from the button
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = sender
        }
        self.present(actionSheet, animated: true)
    }
    
    func segueToWebImageSearch() {
        performSegue(withIdentifier: "fromSecOneToWebImageSearchVC", sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        cardTextView.isHidden = true
        cardImageView.isHidden = false
        deleteFieldUIButton.isHidden = false
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        cardImageView.image = image
        NotificationCenter.default.post(name: .cardTopSectionFilled, object: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

















