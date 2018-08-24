//
//  TwoSectionsContainerViewController.swift
//  FlashStash
//
//  Created by Adam on 01/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class TwoSectionsContainerViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    fileprivate struct Constants {
        static var placeholderText = "Please enter your note here:"
    }
    //
    // MARK: - Properties
    //
    private var topImage: UIImage?
    private var topText: String?
    private var bottomImage: UIImage?
    private var bottomText: String?
    private var isTop = true
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topTextView: UITextView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var bottomTextView: UITextView!
    @IBOutlet weak var topDeleteBtn: UIButton!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextView.delegate = self
        bottomTextView.delegate = self
        addObservers()
    }
    //
    // MARK: - Methods
    //
    private func clearCard() {
        clearTopSection()
        clearBottomSection()
    }
    private func clearTopSection() {
        topDeleteBtn.isHidden = true
        topImage = nil
        topText = nil
        topImageView.image = nil
        topTextView.text = nil
        topTextView.isHidden = true
        topImageView.isHidden = true
    }
    private func clearBottomSection() {
        bottomImage = nil
        bottomText = nil
        bottomImageView.image = nil
        bottomTextView.text = nil
        bottomTextView.isHidden = true
        bottomImageView.isHidden = true
    }
    private func setupCard() {
        if let topText = topText,
            !topText.isEmpty {
            topDeleteBtn.isHidden = false
            topTextView.text = topText
            topTextView.centerText()
            topTextView.isHidden = false
        } else if let topImage = topImage {
            topDeleteBtn.isHidden = false
            topImageView.isHidden = false
            topImageView.image = topImage
        }
        if let bottomText = bottomText,
            !bottomText.isEmpty {
            bottomTextView.text = bottomText
            bottomTextView.centerText()
            bottomTextView.isHidden = false
        } else if let bottomImage = bottomImage {
            bottomImageView.isHidden = false
            bottomImageView.image = bottomImage
        }
    }
    func addPlaceholderText() {
        if isTop {
            topTextView.text = Constants.placeholderText
            topTextView.textColor = .lightGray
        } else {
            bottomTextView.text = Constants.placeholderText
            bottomTextView.textColor = .lightGray
        }
    }
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(addMedia), name: .sendCardMedia, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addMedia), name: .addFieldBtnTapped, object: nil)
    }
    @objc private func addMedia(notification: Notification) {
        clearCard()
        tryToLoadFromCardSide(notification)
        tryToLoadTopSectionFromSentMedia(notification)
        setupCard()
    }
    private func tryToLoadFromCardSide(_ notification: Notification) {
        guard let cardSide = notification.object as? TempSide else {return}
        if let image = cardSide.top?.image {
            self.topImage = image
        } else if let text = cardSide.top?.text,
            !text.isEmpty {
            self.topText = text
        }
        if let image = cardSide.bottom?.image {
            self.bottomImage = image
        } else if let text = cardSide.bottom?.text,
            !text.isEmpty {
            self.bottomText = text
        }
    }
    private func tryToLoadTopSectionFromSentMedia(_ notification: Notification) {
        if let text = notification.object as? String,
            !text.isEmpty {
            topText = text
        } else if let image = notification.object as? UIImage {
        topImage = image
        }
    }
    //
    // MARK: - Delegate @ Data Source Methods
    //
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        // Reduces the height of the text field when the keyboard popsup.
////        cardTextView.frame.size.height -= textViewMargin
//        if topTextView.text == Constants.placeholderText {
//            topTextView.text = ""
//            topTextView.textColor = .black
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if let text = cardTextView.text {
//            self.text = text.isEmpty || text == Constants.placeholderText ? nil : text
//            NotificationCenter.default.post(name: .cardTopSectionFilled, object: self.text)
//            setupCard()
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.cardTextView.frame.size.height += self.textViewMargin
//            UIView.animate(withDuration: 0.5) {
//                self.cardTextView.centerText()
//            }
//        }
//    }
    //
    // MARK: - Actions
    //
    @IBAction func addTopImageTapped(_ sender: UIButton) {
        isTop = true
        showPictureInputActionSheet()
    }
    @IBAction func addTopTextViewTapped(_ sender: UIButton) {
        isTop = true
        addPlaceholderText()
    }
    @IBAction func topDeleteBtnTapped(_ sender: UIButton) {
        clearTopSection()
    }
    @IBAction func addBottomImageBtnTapped(_ sender: UIButton) {
        isTop = false
        showPictureInputActionSheet()
    }
    @IBAction func addBottomTextViewBtnTapped(_ sender: UIButton) {
        isTop = false
        addPlaceholderText()
    }
    @IBAction func deleteBottomSection(_ sender: UIButton) {
        clearBottomSection()
        if bottomTextView.isHidden && bottomImageView.isHidden {
            NotificationCenter.default.post(name: .deleteBottomSectionBtnTapped, object: nil)
        }
    }
}
//
// MARK: - Extensions
//
extension TwoSectionsContainerViewController {
    
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
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if isTop {
            topImage = image
            NotificationCenter.default.post(name: .cardTopSectionFilled, object: image)
        } else {
            bottomImage = image
            NotificationCenter.default.post(name: .cardBottomSectionFilled, object: image)
        }
        setupCard()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
