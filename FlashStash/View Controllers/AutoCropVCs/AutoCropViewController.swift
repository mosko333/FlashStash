////
////  AutoCropViewController.swift
////  FlashStash
////
////  Created by Adam on 07/08/2018.
////  Copyright © 2018 Adam Moskovich. All rights reserved.
////
//
//
//import UIKit
//
class AutoCropViewController: UIViewController { }
//
//    //////////////////////
//    // TODO: Replace With Model
//    //////////////////////
//    var photo: UIImage!
//    //var categoryPicked: CategoryCD?
//
//    IBOutlet weak var cameraViewController: AutoCropCameraScanner!
//    IBOutlet weak var focusIndicator: UIImageView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        cameraViewController.setupCameraView()
//        cameraViewController.isEnableBorderDetection = true
//        cameraViewController.cameraViewType = .normal
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        cameraViewController.start()
//    }
//
//    @IBAction func focusGesture(_ sender: UITapGestureRecognizer) {
//        if sender.state == UIGestureRecognizerState.recognized {
//            let location: CGPoint = sender.location(in: self.cameraViewController)
//            focusIndicatorAnimate(to: location)
//            cameraViewController.focus(at: location, completionHandler: {() -> Void in
//                self.focusIndicatorAnimate(to: location)
//            })
//        }
//    }
//
//    func focusIndicatorAnimate(to targetPoint: CGPoint) {
//        focusIndicator.center = targetPoint
//        focusIndicator.alpha = 0.0
//        focusIndicator.isHidden = false
//        UIView.animate(withDuration: 0.4, animations: {() -> Void in
//            self.focusIndicator.alpha = 1.0
//        }, completion: {(_ finished: Bool) -> Void in
//            UIView.animate(withDuration: 0.4, animations: {() -> Void in
//                self.focusIndicator.alpha = 0.0
//            })
//        })
//    }
//
//    func change(_ button: UIButton, targetTitle title: String, toStateEnabled enabled: Bool) {
//        button.setTitle(title, for: .normal)
//        button.setTitleColor((enabled) ? UIColor(red: CGFloat(1), green: CGFloat(0.81), blue: CGFloat(0), alpha: CGFloat(1)) : UIColor.white, for: .normal)
//    }
//
//    IBAction func cancelBtnPresses(_ sender: UIBarButtonItem) {
//        dismiss(animated: true)
//    }
//    IBAction func captureButton(_ sender: UIButton) {
//        cameraViewController.captureImage(withCompletionHander: {(_ imageFilePath: String) -> Void in
//            let captureImageView = UIImageView(image: UIImage(contentsOfFile: imageFilePath))
//
//            //////////////////////
//            // TODO: Replace With Model
//            //////////////////////
//            print("image is captured")
//            self.photo = captureImageView.image
//            self.performSegue(withIdentifier: "toDetailVC", sender: self)
//        })
//    }
//
//    @objc func dismissPreview(_ dismissTap: UITapGestureRecognizer) {
//        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {() -> Void in
//            dismissTap.view?.frame = self.view.bounds.offsetBy(dx: CGFloat(0), dy: CGFloat(self.view.bounds.size.height))
//        }, completion: {(_ finished: Bool) -> Void in
//            dismissTap.view?.removeFromSuperview()
//        })
//    }
//
//
//
//    // MARK: - Navigation
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toDetailVC" {
//            if let destinationVC = segue.destination as? PhotoPreviewViewController {
//                //////////////////////
//                // TODO: Replace With Model
//                //////////////////////
//                destinationVC.photo = photo
//                destinationVC.categoryPicked = categoryPicked
//            }
//        }
//    }
//}
//
