////
////  PhotoPreviewViewController.swift
////  FlashStash
////
////  Created by Adam on 07/08/2018.
////  Copyright © 2018 Adam Moskovich. All rights reserved.
////
//
//
//import UIKit
//
class PhotoPreviewViewController: UIViewController {}
//
//    //////////////////////
//    // TODO: Replace With Model
//    //////////////////////
//    var photo: UIImage?
//    var categoryPicked: CategoryCD?
//
//    IBOutlet weak var photoImageView: UIImageView!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        updateView()
//    }
//    IBAction func saveBtnTapped(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "toNewAddItemVC", sender: self)
//        guard let photo = photo else {return}
//        print("recepit save button pressed")
//        CoreDataController.shared.photos.append(photo)
//
//    }
//
//    func updateView() {
//        //////////////////////
//        // TODO: Replace
//        //////////////////////
//        DispatchQueue.main.async {
//            self.photoImageView.image = self.photo
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toNewAddItemVC"{
//            let destinationVC = segue.destination as! UINavigationController
//            let topVC = destinationVC.topViewController as! AddItemTableViewController
//            topVC.image = photo
//            topVC.categoryPicked = categoryPicked
//        }
//    }
//
//}
