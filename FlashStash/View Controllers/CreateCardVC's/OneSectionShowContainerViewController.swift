//
//  OneSectionShowContainerViewController.swift
//  FlashStash
//
//  Created by Adam on 01/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class OneSectionShowContainerViewController: UIViewController, UITextViewDelegate {
    
    var text: String?
    var image: UIImage?

    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var deleteFieldUIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.delegate = self
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if questionTextView.text.isEmpty == false {
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.5) {
                self.questionTextView.centerText()
            }
        }
    }
    
    @IBAction func deleteFieldBtnTapped(_ sender: UIButton) {
        questionTextView.isHidden = true
        questionImageView.isHidden = true
        deleteFieldUIButton.isHidden = true
        NotificationCenter.default.post(name: .deleteTopSectionBtnTapped, object: nil)
    }
    
    @IBAction func addImageBtnTapped(_ sender: UIButton) {
        questionTextView.isHidden = true
        questionImageView.isHidden = false
        deleteFieldUIButton.isHidden = false
        showPictureInputActionSheet()
        NotificationCenter.default.post(name: .topImageBtnTapped, object: nil)
    }
    
    @IBAction func addTextBtnTapped(_ sender: UIButton) {
        questionTextView.isHidden = false
        questionTextView.centerText()
        questionImageView.isHidden = true
        deleteFieldUIButton.isHidden = false
        NotificationCenter.default.post(name: .topTextBtnTapped, object: nil)

    }
    
    @IBAction func addFieldBtnTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .addFieldBtnTapped, object: nil)
    }
}

extension OneSectionShowContainerViewController {
    
    func showPictureInputActionSheet() {
        let actionSheet = UIAlertController()
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Scan", style: .default, handler: { (action:UIAlertAction) in

        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action:UIAlertAction) in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
}

















