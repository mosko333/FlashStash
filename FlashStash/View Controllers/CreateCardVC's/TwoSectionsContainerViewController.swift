//
//  TwoSectionsContainerViewController.swift
//  FlashStash
//
//  Created by Adam on 01/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class TwoSectionsContainerViewController: UIViewController {

    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topTextView: UITextView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var bottomTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addBottomImageBtnTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .bottomImageBtnTapped, object: nil)
    }
    @IBAction func addBottomTextViewBtnTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: .bottomTextBtnTapped, object: nil)
    }
    @IBAction func deleteBottomSection(_ sender: UIButton) {
        NotificationCenter.default.post(name: .deleteBottomSection, object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
